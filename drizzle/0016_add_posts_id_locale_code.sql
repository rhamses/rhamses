-- Add id_locale_code foreign key to posts table
ALTER TABLE "edp_posts" ADD COLUMN "id_locale_code" INTEGER REFERENCES "edp_locales"("id") ON DELETE SET NULL;
CREATE INDEX IF NOT EXISTS "posts_id_locale_code_idx" ON "edp_posts" ("id_locale_code");
