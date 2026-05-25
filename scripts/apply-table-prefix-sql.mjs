#!/usr/bin/env node
/**
 * Aplica prefixo edp_ em arquivos SQL de migração e seed.
 * Uso: node scripts/apply-table-prefix-sql.mjs
 */
import { readFileSync, writeFileSync, readdirSync, statSync } from "node:fs";
import { join } from "node:path";

const PREFIX = "edp_";
const ROOT = join(process.cwd(), "drizzle");

const TABLES = [
  "translations_languages",
  "posts_taxonomies",
  "posts_media",
  "role_capability",
  "post_types",
  "taxonomies",
  "translations",
  "settings",
  "locales",
  "verification",
  "session",
  "account",
  "posts",
  "user",
];

function prefixSql(content) {
  let result = content;

  for (const table of TABLES) {
    const prefixed = PREFIX + table;

    result = result.replaceAll(`\`${table}\``, `\`${prefixed}\``);

    const keywords = ["INTO", "FROM", "JOIN", "UPDATE", "TABLE", "REFERENCES", "EXISTS"];
    for (const kw of keywords) {
      const re = new RegExp(`\\b${kw}\\s+${table}\\b`, "gi");
      result = result.replace(re, `${kw} ${prefixed}`);
    }

    // Índices: posts_slug_unique → edp_posts_slug_unique (sem afetar colunas user_id, etc.)
    result = result.replaceAll(`INDEX \`${table}_`, `INDEX \`${prefixed}_`);
    result = result.replaceAll(`UNIQUE INDEX \`${table}_`, `UNIQUE INDEX \`${prefixed}_`);
    result = result.replaceAll(`ON \`${table}\` `, `ON \`${prefixed}\` `);
  }

  return result;
}

function walkSqlFiles(dir, files = []) {
  for (const entry of readdirSync(dir)) {
    const full = join(dir, entry);
    const stat = statSync(full);
    if (stat.isDirectory()) {
      walkSqlFiles(full, files);
    } else if (entry.endsWith(".sql")) {
      files.push(full);
    }
  }
  return files;
}

const files = walkSqlFiles(ROOT);
for (const file of files) {
  const original = readFileSync(file, "utf8");
  const updated = prefixSql(original);
  if (updated !== original) {
    writeFileSync(file, updated, "utf8");
    console.log(`[apply-table-prefix-sql] Updated ${file}`);
  }
}

console.log(`[apply-table-prefix-sql] Done (${files.length} files scanned)`);
