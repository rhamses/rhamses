import { readdirSync, readFileSync } from "node:fs";
import { extname, join } from "node:path";
import { createClient } from "@libsql/client/node";
import { and, eq } from "drizzle-orm";
import { drizzle } from "drizzle-orm/libsql";
import * as schema from "../src/db/schema.ts";
import { ensurePostTypesFromDefaults } from "../src/db/seed.ts";
import { markdownToHighlightedHtml } from "../src/utils/shiki-blog-highlight.ts";
import { rewriteLegacyAssetUrls } from "./import-blog-assets.ts";

const WRANGLER_STATE = join(process.cwd(), ".wrangler", "state", "v3", "d1");
const SOURCE_CONTENT_DIR = "/Users/rhamses/Sites/rhams.es/blog/src/data/blog-posts";

type Frontmatter = {
  title: string;
  publishDate: string;
  description: string;
};

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

function parseFrontmatterDocument(content: string): { frontmatter: Frontmatter; body: string } | null {
  if (!content.startsWith("---\n")) return null;
  const end = content.indexOf("\n---\n", 4);
  if (end === -1) return null;

  const rawFrontmatter = content.slice(4, end).trim();
  const body = content.slice(end + 5).trim();
  const values: Record<string, string> = {};

  for (const line of rawFrontmatter.split("\n")) {
    const idx = line.indexOf(":");
    if (idx === -1) continue;
    const key = line.slice(0, idx).trim();
    const value = line.slice(idx + 1).trim();
    values[key] = value;
  }

  const title = values["title"] ?? "";
  const publishDate = values["publishDate"] ?? "";
  const description = values["description"] ?? "";

  if (!title) return null;

  return {
    frontmatter: { title, publishDate, description },
    body,
  };
}

async function ensureRhamsesTheme(
  db: ReturnType<typeof drizzle>,
  typeIds: Record<string, number>,
): Promise<void> {
  const themesTypeId = typeIds["themes"];
  if (!themesTypeId) return;

  const now = Date.now();
  const rhamsesMeta = JSON.stringify({
    theme_slug: "rhamses",
    theme_path: "src/pages/themes/rhamses",
    is_active: "1",
    requested_active: "1",
    supports: "single,archive",
    version: "1.0.0",
    import_source: "rhams.es/blog",
  });

  const [existing] = await db
    .select({ id: schema.posts.id })
    .from(schema.posts)
    .where(and(eq(schema.posts.post_type_id, themesTypeId), eq(schema.posts.slug, "rhamses")))
    .limit(1);

  if (!existing) {
    await db.insert(schema.posts).values({
      post_type_id: themesTypeId,
      title: "Rhamsés Blog",
      slug: "rhamses",
      status: "published",
      meta_values: rhamsesMeta,
      created_at: now,
      updated_at: now,
    });
  } else {
    await db
      .update(schema.posts)
      .set({ meta_values: rhamsesMeta, updated_at: now })
      .where(eq(schema.posts.id, existing.id));
  }

  await db
    .update(schema.settings)
    .set({ value: "rhamses" })
    .where(eq(schema.settings.name, "active_theme"));
}

async function main(): Promise<void> {
  const sqlitePath = findLocalD1Sqlite(WRANGLER_STATE);
  if (!sqlitePath) {
    throw new Error(`Banco D1 local não encontrado em ${WRANGLER_STATE}`);
  }

  const files = readdirSync(SOURCE_CONTENT_DIR).filter((name) => {
    const ext = extname(name).toLowerCase();
    return ext === ".md" || ext === ".mdx";
  });

  if (files.length === 0) {
    console.log("Nenhum arquivo .md/.mdx encontrado para import.");
    return;
  }

  const client = createClient({ url: `file:${sqlitePath}` });
  const db = drizzle(client, { schema });

  try {
    const typeIds = await ensurePostTypesFromDefaults(db);
    const postTypeId = typeIds["post"];
    if (!postTypeId) throw new Error("Post type 'post' não encontrado.");

    const [ptBrLocale] = await db
      .select({ id: schema.locales.id })
      .from(schema.locales)
      .where(eq(schema.locales.locale_code, "pt_BR"))
      .limit(1);

    const localeId = ptBrLocale?.id ?? null;

    const pageTypeId = typeIds["page"];
    let blogParentId: number | null = null;
    if (pageTypeId) {
      const [existingHub] = await db
        .select({ id: schema.posts.id })
        .from(schema.posts)
        .where(and(eq(schema.posts.post_type_id, pageTypeId), eq(schema.posts.slug, "blog")))
        .limit(1);

      if (existingHub) {
        blogParentId = existingHub.id;
      } else {
        const now = Date.now();
        const [insertedHub] = await db
          .insert(schema.posts)
          .values({
            post_type_id: pageTypeId,
            title: "Blog",
            slug: "blog",
            status: "published",
            meta_values: JSON.stringify({ import_source: "rhams.es/blog" }),
            id_locale_code: localeId,
            published_at: now,
            created_at: now,
            updated_at: now,
          })
          .returning({ id: schema.posts.id });
        blogParentId = insertedHub?.id ?? null;
      }
    }

    let importedCount = 0;
    let updatedCount = 0;

    for (const filename of files) {
      const slug = filename.replace(/\.(md|mdx)$/i, "");
      const fullPath = join(SOURCE_CONTENT_DIR, filename);
      const raw = readFileSync(fullPath, "utf-8");
      const parsed = parseFrontmatterDocument(raw);
      if (!parsed) {
        console.warn(`Pulando '${filename}': frontmatter inválido.`);
        continue;
      }

      const bodyMarkdown = rewriteLegacyAssetUrls(parsed.body);
      const bodyHtml = await markdownToHighlightedHtml(bodyMarkdown);
      const publishedAt = Number.isNaN(Date.parse(parsed.frontmatter.publishDate))
        ? Date.now()
        : Date.parse(parsed.frontmatter.publishDate);
      const now = Date.now();

      const metaValues = JSON.stringify({
        import_source: "rhams.es/blog/src/data/blog-posts",
        import_publish_date: parsed.frontmatter.publishDate,
      });

      const [existing] = await db
        .select({ id: schema.posts.id })
        .from(schema.posts)
        .where(and(eq(schema.posts.post_type_id, postTypeId), eq(schema.posts.slug, slug)))
        .limit(1);

      if (existing) {
        await db
          .update(schema.posts)
          .set({
            title: parsed.frontmatter.title,
            excerpt: parsed.frontmatter.description,
            body: bodyHtml,
            status: "published",
            meta_values: metaValues,
            id_locale_code: localeId,
            parent_id: blogParentId,
            published_at: publishedAt,
            updated_at: now,
          })
          .where(eq(schema.posts.id, existing.id));
        updatedCount += 1;
      } else {
        await db.insert(schema.posts).values({
          post_type_id: postTypeId,
          parent_id: blogParentId,
          title: parsed.frontmatter.title,
          slug,
          excerpt: parsed.frontmatter.description,
          body: bodyHtml,
          status: "published",
          meta_values: metaValues,
          id_locale_code: localeId,
          published_at: publishedAt,
          created_at: now,
          updated_at: now,
        });
        importedCount += 1;
      }
    }

    await ensureRhamsesTheme(db, typeIds);
    console.log(`Tema ativo: rhamses.`);
    console.log(`Importação concluída. Inseridos: ${importedCount}. Atualizados: ${updatedCount}.`);
  } finally {
    client.close();
  }
}

main().catch((err) => {
  console.error("Erro ao importar conteúdo do blog:", err);
  process.exit(1);
});
