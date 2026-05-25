-- Migration: Make post_type_id NOT NULL
-- Date: 2026-02-06
-- Description: Prepare and enforce post_type_id as NOT NULL

-- ============================================
-- STEP 1: Clean up orphaned data
-- ============================================

-- Deletar posts sem post_type_id (dados órfãos)
DELETE FROM "edp_posts_taxonomies" WHERE "post_id" IN (
  SELECT "id" FROM "edp_posts" WHERE "post_type_id" IS NULL
);

DELETE FROM "edp_posts_media" WHERE "post_id" IN (
  SELECT "id" FROM "edp_posts" WHERE "post_type_id" IS NULL
);

DELETE FROM "edp_posts" WHERE "post_type_id" IS NULL;

-- ============================================
-- STEP 2: Set default post_type for existing null values (if any remain)
-- ============================================

-- Buscar ID do post_type "post" (padrão)
-- Se não existir nenhum post_type_id null, esta query não faz nada
UPDATE "edp_posts" 
SET "post_type_id" = (
  SELECT "id" FROM "edp_post_types" WHERE "slug" = 'post' LIMIT 1
)
WHERE "post_type_id" IS NULL;

-- ============================================
-- STEP 3: Recreate table with NOT NULL constraint
-- ============================================
-- NOTA: SQLite não suporta ALTER COLUMN, então precisamos recriar a tabela

-- Criar tabela temporária com nova estrutura
CREATE TABLE "posts_new" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "post_type_id" INTEGER NOT NULL REFERENCES "edp_post_types"("id") ON DELETE RESTRICT,
  "author_id" TEXT REFERENCES "edp_user"("id") ON DELETE SET NULL,
  "title" TEXT NOT NULL,
  "slug" TEXT NOT NULL UNIQUE,
  "excerpt" TEXT,
  "body" TEXT,
  "status" TEXT DEFAULT 'draft' CHECK ("status" IN ('published', 'draft', 'archived')),
  "meta_values" TEXT,
  "published_at" INTEGER,
  "created_at" INTEGER,
  "updated_at" INTEGER
);

-- Copiar dados da tabela antiga (especificar colunas explicitamente para evitar conflito com parent_id)
INSERT INTO "posts_new" (
  "id",
  "post_type_id",
  "author_id",
  "title",
  "slug",
  "excerpt",
  "body",
  "status",
  "meta_values",
  "published_at",
  "created_at",
  "updated_at"
)
SELECT 
  "id",
  "post_type_id",
  "author_id",
  "title",
  "slug",
  "excerpt",
  "body",
  "status",
  "meta_values",
  "published_at",
  "created_at",
  "updated_at"
FROM "edp_posts";

-- Dropar tabela antiga
DROP TABLE "edp_posts";

-- Renomear tabela nova
ALTER TABLE "posts_new" RENAME TO "edp_posts";

-- Recriar índices
CREATE INDEX "edp_posts_post_type_id_idx" ON "edp_posts" ("post_type_id");
CREATE INDEX "edp_posts_author_id_idx" ON "edp_posts" ("author_id");
CREATE INDEX "edp_posts_status_idx" ON "edp_posts" ("status");
CREATE INDEX "edp_posts_created_at_idx" ON "edp_posts" ("created_at");
CREATE INDEX "edp_posts_updated_at_idx" ON "edp_posts" ("updated_at");
CREATE INDEX "edp_posts_slug_idx" ON "edp_posts" ("slug");
CREATE UNIQUE INDEX "edp_posts_slug_unique" ON "edp_posts" ("slug");
