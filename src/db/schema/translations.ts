import { index, int, sqliteTable, text } from "drizzle-orm/sqlite-core";
import { indexName, tableName } from "../table-prefix.ts";

/**
 * Tabela de traduções
 * Armazena chaves de tradução organizadas por namespace
 */
export const translations = sqliteTable(
  tableName("translations"),
  {
    id: int().primaryKey({ autoIncrement: true }),
    namespace: text("namespace").notNull(),
    key: text().notNull(),
    created_at: int("created_at"),
    updated_at: int("updated_at"),
  },
  (table) => ({
    namespaceIdx: index(indexName("translations_namespace_idx")).on(table.namespace),
    keyIdx: index(indexName("translations_key_idx")).on(table.key),
    namespaceKeyIdx: index(indexName("translations_namespace_key_idx")).on(
      table.namespace,
      table.key
    ),
  })
);
