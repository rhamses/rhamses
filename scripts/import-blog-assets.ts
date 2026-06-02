/**
 * Copia imagens/vídeos do blog legado para o bucket R2 local (edgepress-media)
 * e reescreve URLs nos posts importados.
 *
 * Uso: npm run db:import:blog-assets
 */
import { execFileSync } from "node:child_process";
import { basename, extname, join, relative } from "node:path";
import { readdirSync, statSync } from "node:fs";
import { createClient } from "@libsql/client/node";
import { and, eq, like, or } from "drizzle-orm";
import { drizzle } from "drizzle-orm/libsql";
import * as schema from "../src/db/schema.ts";
import { ensurePostTypesFromDefaults } from "../src/db/seed.ts";
import { parseMetaValues } from "../src/utils/meta-parser.ts";

const WRANGLER_STATE = join(process.cwd(), ".wrangler", "state", "v3", "d1");
const BUCKET = "edgepress-media";
const R2_PREFIX = "uploads/blog";

const LEGACY_BLOG_ROOT = "/Users/rhamses/Sites/rhams.es/blog/public";
const LEGACY_BLOG_ASSETS = join(LEGACY_BLOG_ROOT, "assets", "blog");
const LEGACY_SHARED_ASSETS = join(LEGACY_BLOG_ROOT, "assets");

const MIME_BY_EXT: Record<string, string> = {
  ".jpg": "image/jpeg",
  ".jpeg": "image/jpeg",
  ".png": "image/png",
  ".gif": "image/gif",
  ".webp": "image/webp",
  ".avif": "image/avif",
  ".svg": "image/svg+xml",
  ".ico": "image/x-icon",
  ".mp4": "video/mp4",
};

const SHARED_ASSET_FILES = [
  "logo.webp",
  "social.png",
  "about-illustration.webp",
  "home-illustration.webp",
  "home-illustration-small.webp",
];

function findLocalD1Sqlite(dir: string): string | null {
  try {
    const entries = readdirSync(dir, { withFileTypes: true });
    for (const e of entries) {
      const full = join(dir, e.name);
      if (e.isDirectory()) {
        const found = findLocalD1Sqlite(full);
        if (found) return found;
      } else if (e.isFile() && e.name.endsWith(".sqlite")) {
        return full;
      }
    }
  } catch {
    // ignore
  }
  return null;
}

function mimeFor(filePath: string): string {
  const ext = extname(filePath).toLowerCase();
  return MIME_BY_EXT[ext] ?? "application/octet-stream";
}

function walkFiles(dir: string): string[] {
  const out: string[] = [];
  for (const entry of readdirSync(dir, { withFileTypes: true })) {
    const full = join(dir, entry.name);
    if (entry.isDirectory()) {
      out.push(...walkFiles(full));
    } else if (entry.isFile()) {
      out.push(full);
    }
  }
  return out;
}

function putR2Object(r2Key: string, filePath: string): void {
  const contentType = mimeFor(filePath);
  execFileSync(
    "npx",
    [
      "wrangler",
      "r2",
      "object",
      "put",
      `${BUCKET}/${r2Key}`,
      "--file",
      filePath,
      "--content-type",
      contentType,
      "--local",
      "-c",
      "wrangler.toml",
    ],
    { stdio: "pipe", cwd: process.cwd() },
  );
}

/** /blog/assets/blog/x, /assets/blog/x → /api/media/uploads/blog/x */
export function rewriteLegacyAssetUrls(html: string): string {
  return html
    .replace(/\/blog\/assets\/blog\//g, `/api/media/${R2_PREFIX}/`)
    .replace(/(?<![\w-])\/assets\/blog\//g, `/api/media/${R2_PREFIX}/`);
}

type UploadedAsset = {
  rel: string;
  r2Key: string;
  attachmentPath: string;
  fileName: string;
  mimeType: string;
};

function attachmentPathFromR2Key(r2Key: string): string {
  return r2Key.startsWith("/") ? r2Key : `/${r2Key}`;
}

function slugForAsset(rel: string): string {
  const base = rel
    .replace(/\\/g, "/")
    .replace(/\//g, "-")
    .replace(/\.[^.]+$/i, "")
    .toLowerCase()
    .replace(/[^a-z0-9-]+/g, "-")
    .replace(/^-+|-+$/g, "");
  return `blog-${base || "asset"}`.slice(0, 200);
}

async function uploadLegacyAssets(): Promise<{
  uploaded: number;
  skipped: number;
  assets: UploadedAsset[];
}> {
  let uploaded = 0;
  let skipped = 0;
  const assets: UploadedAsset[] = [];

  const blogFiles = walkFiles(LEGACY_BLOG_ASSETS);
  for (const filePath of blogFiles) {
    const rel = relative(LEGACY_BLOG_ASSETS, filePath).replace(/\\/g, "/");
    const r2Key = `${R2_PREFIX}/${rel}`;
    try {
      putR2Object(r2Key, filePath);
      uploaded += 1;
      assets.push({
        rel,
        r2Key,
        attachmentPath: attachmentPathFromR2Key(r2Key),
        fileName: basename(filePath),
        mimeType: mimeFor(filePath),
      });
    } catch (err) {
      console.warn(`Falha ao enviar ${rel}:`, err);
      skipped += 1;
    }
  }

  for (const name of SHARED_ASSET_FILES) {
    const filePath = join(LEGACY_SHARED_ASSETS, name);
    try {
      if (!statSync(filePath).isFile()) continue;
      const r2Key = `${R2_PREFIX}/${name}`;
      putR2Object(r2Key, filePath);
      uploaded += 1;
      assets.push({
        rel: name,
        r2Key,
        attachmentPath: attachmentPathFromR2Key(r2Key),
        fileName: name,
        mimeType: mimeFor(filePath),
      });
    } catch (err) {
      console.warn(`Falha ao enviar asset compartilhado ${name}:`, err);
      skipped += 1;
    }
  }

  const faviconPath = join(LEGACY_BLOG_ROOT, "favicon.ico");
  try {
    if (statSync(faviconPath).isFile()) {
      const r2Key = `${R2_PREFIX}/favicon.ico`;
      putR2Object(r2Key, faviconPath);
      uploaded += 1;
      assets.push({
        rel: "favicon.ico",
        r2Key,
        attachmentPath: attachmentPathFromR2Key(r2Key),
        fileName: "favicon.ico",
        mimeType: mimeFor(faviconPath),
      });
    }
  } catch {
    // opcional
  }

  return { uploaded, skipped, assets };
}

async function getAttachmentTypeId(db: ReturnType<typeof drizzle>): Promise<number> {
  const [row] = await db
    .select({ id: schema.postTypes.id })
    .from(schema.postTypes)
    .where(eq(schema.postTypes.slug, "attachment"))
    .limit(1);
  if (!row) throw new Error("post type 'attachment' não encontrado — rode db:seed");
  return row.id;
}

async function getPostTypeId(db: ReturnType<typeof drizzle>, slug: string): Promise<number | null> {
  const [row] = await db
    .select({ id: schema.postTypes.id })
    .from(schema.postTypes)
    .where(eq(schema.postTypes.slug, slug))
    .limit(1);
  return row?.id ?? null;
}

async function findAttachmentIdByPath(
  db: ReturnType<typeof drizzle>,
  attachmentTypeId: number,
  attachmentPath: string,
): Promise<number | null> {
  const [row] = await db
    .select({ id: schema.posts.id })
    .from(schema.posts)
    .where(
      and(
        eq(schema.posts.post_type_id, attachmentTypeId),
        like(schema.posts.meta_values, `%"attachment_path":"${attachmentPath}"%`),
      ),
    )
    .limit(1);
  return row?.id ?? null;
}

async function ensureUniqueSlug(
  db: ReturnType<typeof drizzle>,
  baseSlug: string,
): Promise<string> {
  let slug = baseSlug;
  let n = 2;
  while (true) {
    const [existing] = await db
      .select({ id: schema.posts.id })
      .from(schema.posts)
      .where(eq(schema.posts.slug, slug))
      .limit(1);
    if (!existing) return slug;
    slug = `${baseSlug}-${n}`;
    n += 1;
  }
}

async function registerAttachmentsInDb(
  db: ReturnType<typeof drizzle>,
  assets: UploadedAsset[],
): Promise<Map<string, number>> {
  const attachmentTypeId = await getAttachmentTypeId(db);
  const pathToId = new Map<string, number>();
  const now = Date.now();
  let created = 0;
  let reused = 0;

  for (const asset of assets) {
    if (!asset.mimeType.startsWith("image/")) continue;

    let mediaId = await findAttachmentIdByPath(db, attachmentTypeId, asset.attachmentPath);
    if (!mediaId) {
      const baseSlug = slugForAsset(asset.rel);
      const slug = await ensureUniqueSlug(db, baseSlug);
      const meta = {
        mime_type: asset.mimeType,
        attachment_file: asset.fileName,
        attachment_path: asset.attachmentPath,
      };
      const [inserted] = await db
        .insert(schema.posts)
        .values({
          post_type_id: attachmentTypeId,
          title: asset.fileName,
          slug,
          status: "published",
          meta_values: JSON.stringify(meta),
          published_at: now,
          created_at: now,
          updated_at: now,
        })
        .returning({ id: schema.posts.id });
      mediaId = inserted?.id ?? null;
      if (mediaId) created += 1;
    } else {
      reused += 1;
    }

    if (mediaId) {
      pathToId.set(asset.attachmentPath, mediaId);
      pathToId.set(`/api/media${asset.attachmentPath}`, mediaId);
    }
  }

  console.log(`Attachments no D1: ${created} criado(s), ${reused} já existente(s).`);
  return pathToId;
}

const UPLOADS_BLOG_PATH_RE = /(?:\/api\/media)?(\/uploads\/blog\/[^\s"'<>]+)/g;

function extractUploadPathsFromHtml(html: string): string[] {
  const paths = new Set<string>();
  for (const match of html.matchAll(UPLOADS_BLOG_PATH_RE)) {
    const path = match[1];
    if (path) paths.add(path);
  }
  return [...paths];
}

function resolveCoverAttachmentPath(slug: string, pathToId: Map<string, number>): number | null {
  for (const name of ["capa.webp", "capa.jpg", "capa.jpeg", "capa.png"]) {
    const path = `/uploads/blog/${slug}/${name}`;
    const id = pathToId.get(path);
    if (id) return id;
  }
  return null;
}

async function linkPostsToAttachments(
  db: ReturnType<typeof drizzle>,
  pathToId: Map<string, number>,
): Promise<{ mediaLinks: number; thumbnails: number }> {
  const postTypeId = await getPostTypeId(db, "post");
  if (!postTypeId) return { mediaLinks: 0, thumbnails: 0 };

  const rows = await db
    .select({
      id: schema.posts.id,
      slug: schema.posts.slug,
      body: schema.posts.body,
      meta_values: schema.posts.meta_values,
    })
    .from(schema.posts)
    .where(eq(schema.posts.post_type_id, postTypeId));

  let mediaLinks = 0;
  let thumbnails = 0;

  for (const row of rows) {
    const linkedMedia = new Set<number>();
    const body = row.body ?? "";

    for (const path of extractUploadPathsFromHtml(body)) {
      const mediaId = pathToId.get(path);
      if (!mediaId) continue;
      linkedMedia.add(mediaId);
    }

    const coverId = resolveCoverAttachmentPath(row.slug, pathToId);
    if (coverId) linkedMedia.add(coverId);

    for (const mediaId of linkedMedia) {
      try {
        await db.insert(schema.postsMedia).values({
          post_id: row.id,
          media_id: mediaId,
        });
        mediaLinks += 1;
      } catch {
        // já vinculado (PK)
      }
    }

    if (coverId) {
      const meta = parseMetaValues(row.meta_values) as Record<string, unknown>;
      if (meta["post_thumbnail_id"] !== coverId) {
        meta["post_thumbnail_id"] = coverId;
        await db
          .update(schema.posts)
          .set({ meta_values: JSON.stringify(meta), updated_at: Date.now() })
          .where(eq(schema.posts.id, row.id));
        thumbnails += 1;
      }
    }
  }

  return { mediaLinks, thumbnails };
}

async function rewriteImportedPostBodies(db: ReturnType<typeof drizzle>): Promise<number> {
  const rows = await db
    .select({ id: schema.posts.id, body: schema.posts.body })
    .from(schema.posts)
    .where(
      or(
        like(schema.posts.body, "%/assets/blog/%"),
        like(schema.posts.body, "%/blog/assets/blog/%"),
      ),
    );

  let updated = 0;
  for (const row of rows) {
    if (!row.body) continue;
    const next = rewriteLegacyAssetUrls(row.body);
    if (next === row.body) continue;
    await db
      .update(schema.posts)
      .set({ body: next, updated_at: Date.now() })
      .where(eq(schema.posts.id, row.id));
    updated += 1;
  }
  return updated;
}

async function main(): Promise<void> {
  const sqlitePath = findLocalD1Sqlite(WRANGLER_STATE);
  if (!sqlitePath) {
    throw new Error(`Banco D1 local não encontrado em ${WRANGLER_STATE}`);
  }

  console.log("Enviando assets do blog legado para R2 local...");
  const { uploaded, skipped, assets } = await uploadLegacyAssets();
  console.log(`R2: ${uploaded} arquivo(s) enviado(s), ${skipped} falha(s).`);

  const client = createClient({ url: `file:${sqlitePath}` });
  const db = drizzle(client, { schema });
  try {
    await ensurePostTypesFromDefaults(db);
    const postsUpdated = await rewriteImportedPostBodies(db);
    console.log(`Posts com URLs reescritas: ${postsUpdated}.`);

    const pathToId = await registerAttachmentsInDb(db, assets);
    const { mediaLinks, thumbnails } = await linkPostsToAttachments(db, pathToId);
    console.log(`Vínculos posts_media: ${mediaLinks}, capas (post_thumbnail_id): ${thumbnails}.`);
  } finally {
    client.close();
  }
}

const isMain =
  typeof process.argv[1] === "string" &&
  import.meta.url.endsWith(process.argv[1].replace(/\\/g, "/"));

if (isMain) {
  main().catch((err) => {
    console.error("Erro ao importar assets do blog:", err);
    process.exit(1);
  });
}
