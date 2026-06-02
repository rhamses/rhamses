-- Add 'trash' to posts.status allowed values
-- SQLite does not support ALTER COLUMN to change CHECK, so we recreate the table.

CREATE TABLE "posts_new" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "post_type_id" INTEGER NOT NULL REFERENCES "edp_post_types"("id") ON DELETE RESTRICT,
  "parent_id" INTEGER,
  "author_id" TEXT REFERENCES "edp_user"("id") ON DELETE SET NULL,
  "id_locale_code" INTEGER REFERENCES "edp_locales"("id") ON DELETE SET NULL,
  "title" TEXT NOT NULL,
  "slug" TEXT NOT NULL,
  "excerpt" TEXT,
  "body" TEXT,
  "status" TEXT DEFAULT 'draft' CHECK ("status" IN ('published', 'draft', 'archived', 'trash')),
  "meta_values" TEXT,
  "published_at" INTEGER,
  "created_at" INTEGER,
  "updated_at" INTEGER
);

INSERT INTO "posts_new" (
  "id",
  "post_type_id",
  "parent_id",
  "author_id",
  "id_locale_code",
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
  "parent_id",
  "author_id",
  "id_locale_code",
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

DROP TABLE "edp_posts";

ALTER TABLE "posts_new" RENAME TO "edp_posts";

CREATE UNIQUE INDEX "edp_posts_slug_unique" ON "edp_posts" ("slug");
CREATE INDEX "edp_posts_post_type_id_idx" ON "edp_posts" ("post_type_id");
CREATE INDEX "edp_posts_parent_id_idx" ON "edp_posts" ("parent_id");
CREATE INDEX "edp_posts_author_id_idx" ON "edp_posts" ("author_id");
CREATE INDEX "edp_posts_id_locale_code_idx" ON "edp_posts" ("id_locale_code");
CREATE INDEX "edp_posts_status_idx" ON "edp_posts" ("status");
CREATE INDEX "edp_posts_created_at_idx" ON "edp_posts" ("created_at");
CREATE INDEX "edp_posts_updated_at_idx" ON "edp_posts" ("updated_at");
CREATE INDEX "edp_posts_slug_idx" ON "edp_posts" ("slug");
