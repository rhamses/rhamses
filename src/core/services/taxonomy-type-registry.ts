/**
 * Registry global de tipos de taxonomia (built-in + custom via translations namespace taxonomyType).
 */
import { and, eq, isNull, or } from "drizzle-orm";
import { translations, translationsLanguages, taxonomies } from "../../db/schema.ts";
import type { Database } from "../../shared/types/database.ts";
import type { MetaSchemaItem } from "../../db/schema/meta_schema.ts";
import { slugify } from "../../utils/slugify.ts";
import { getTaxonomyTypeRootId } from "./taxonomy-service.ts";

export const TAXONOMY_TYPE_NAMESPACE = "taxonomyType";
export const BUILTIN_TAXONOMY_TYPES = ["category", "tag"] as const;
export type BuiltinTaxonomyType = (typeof BUILTIN_TAXONOMY_TYPES)[number];

export type TaxonomyTypeListItem = {
  type: string;
  label: string;
  isBuiltin: boolean;
};

export type TaxonomyTranslationInput = {
  locale_id: number;
  value: string;
};

/**
 * Monta o array taxonomy do post type (modelo híbrido: inclui taxonomia_{slug} se houver custom selecionado).
 */
export function buildPostTypeTaxonomyArray(
  selectedTypes: string[],
  postTypeSlug: string
): string[] {
  const builtin = new Set<string>(BUILTIN_TAXONOMY_TYPES);
  const trimmed = selectedTypes.map((t) => t.trim()).filter(Boolean);
  const hasCustom = trimmed.some((t) => !builtin.has(t) && !t.startsWith("taxonomia_"));
  const result = [...trimmed];
  if (hasCustom && postTypeSlug.trim()) {
    const bucket = `taxonomia_${postTypeSlug.trim()}`;
    if (!result.includes(bucket)) result.push(bucket);
  }
  return [...new Set(result)];
}

export async function ensureTaxonomyRoots(db: Database, types: string[]): Promise<void> {
  for (const type of types) {
    await getTaxonomyTypeRootId(db, type);
  }
}

/** Remove tipos bucket taxonomia_{slug} da lista exibida em checkboxes. */
export function filterTaxonomyTypesForUi(types: string[]): string[] {
  return types.filter((t) => !t.startsWith("taxonomia_"));
}

export function withTaxonomyInMetaSchema(
  meta_schema: MetaSchemaItem[],
  taxonomy: string[]
): MetaSchemaItem[] {
  const rest = meta_schema.filter((s) => s.key !== "taxonomy");
  return [...rest, { key: "taxonomy", type: "array", default: taxonomy }];
}

export async function applyPostTypeTaxonomySave(
  db: Database,
  meta_schema: MetaSchemaItem[],
  meta_values: Record<string, unknown>,
  postTypeSlug: string
): Promise<{ meta_schema: MetaSchemaItem[]; meta_values: Record<string, unknown> }> {
  const raw = Array.isArray(meta_values.taxonomy)
    ? (meta_values.taxonomy as string[])
    : [];
  const selected = filterTaxonomyTypesForUi(raw.map(String));
  const taxonomy = buildPostTypeTaxonomyArray(selected, postTypeSlug);
  await ensureTaxonomyRoots(db, taxonomy);
  return {
    meta_schema: withTaxonomyInMetaSchema(meta_schema, taxonomy),
    meta_values: { ...meta_values, taxonomy },
  };
}

export async function listTaxonomyTypes(
  db: Database,
  _adminLocale: string
): Promise<TaxonomyTypeListItem[]> {
  const items: TaxonomyTypeListItem[] = BUILTIN_TAXONOMY_TYPES.map((type) => ({
    type,
    label: type,
    isBuiltin: true,
  }));

  const keys = await db
    .select({ key: translations.key, id: translations.id })
    .from(translations)
    .where(eq(translations.namespace, TAXONOMY_TYPE_NAMESPACE));

  const builtinSet = new Set<string>(BUILTIN_TAXONOMY_TYPES);
  for (const row of keys) {
    const type = row.key;
    if (!type || builtinSet.has(type)) continue;

    let label = type;
    const [root] = await db
      .select({ name: taxonomies.name })
      .from(taxonomies)
      .where(
        and(
          eq(taxonomies.type, type),
          or(isNull(taxonomies.parent_id), eq(taxonomies.parent_id, 0))
        )
      )
      .limit(1);
    if (root?.name?.trim()) label = root.name.trim();

    items.push({ type, label, isBuiltin: false });
  }

  return items;
}

async function taxonomyTypeExists(db: Database, slug: string): Promise<boolean> {
  const [tr] = await db
    .select({ id: translations.id })
    .from(translations)
    .where(and(eq(translations.namespace, TAXONOMY_TYPE_NAMESPACE), eq(translations.key, slug)))
    .limit(1);
  if (tr) return true;

  const [tx] = await db
    .select({ id: taxonomies.id })
    .from(taxonomies)
    .where(eq(taxonomies.type, slug))
    .limit(1);
  return Boolean(tx);
}

export async function createTaxonomyType(
  db: Database,
  params: {
    /** Nome da categoria (título inserido no modal; também usado no painel de categorização). */
    name: string;
    translations: TaxonomyTranslationInput[];
  }
): Promise<{ type: string; label: string; key: string }> {
  const name = params.name.trim();
  if (!name) throw new Error("NAME_REQUIRED");

  const slug = slugify(name);
  if (!slug) throw new Error("INVALID_SLUG");

  if (BUILTIN_TAXONOMY_TYPES.includes(slug as BuiltinTaxonomyType)) {
    throw new Error("BUILTIN_RESERVED");
  }

  if (await taxonomyTypeExists(db, slug)) {
    throw new Error("SLUG_EXISTS");
  }

  const now = Date.now();
  const [inserted] = await db
    .insert(translations)
    .values({
      namespace: TAXONOMY_TYPE_NAMESPACE,
      key: slug,
      created_at: now,
      updated_at: now,
    })
    .returning({ id: translations.id });

  if (!inserted) throw new Error("INSERT_FAILED");
  const translationId = inserted.id;

  const seenLocales = new Set<number>();
  for (const row of params.translations) {
    const localeId = row.locale_id;
    const value = (row.value ?? "").trim();
    if (!localeId || !value || seenLocales.has(localeId)) continue;
    seenLocales.add(localeId);
    await db.insert(translationsLanguages).values({
      id_translations: translationId,
      id_locale_code: localeId,
      value,
    });
  }

  await getTaxonomyTypeRootId(db, slug, { displayName: name });

  return { type: slug, key: slug, label: name };
}
