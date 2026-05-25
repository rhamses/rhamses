import { index, int, sqliteTable, text } from "drizzle-orm/sqlite-core";
import { indexName, tableName } from "../table-prefix.ts";

/**
 * Tabela de locales
 * Armazena informações sobre idiomas, países e fusos horários
 */
export const locales = sqliteTable(
  tableName("locales"),
  {
    id: int().primaryKey({ autoIncrement: true }),
    language: text().notNull(),
    hello_world: text().notNull(),
    locale_code: text().notNull().unique(),
    country: text().notNull(),
    timezone: text().notNull(),
  },
  (table) => ({
    localeCodeIdx: index(indexName("locales_locale_code_idx")).on(table.locale_code),
    languageIdx: index(indexName("locales_language_idx")).on(table.language),
  })
);
