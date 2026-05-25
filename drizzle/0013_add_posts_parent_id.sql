-- Add parent_id to posts (self-reference for hierarchy)
ALTER TABLE "edp_posts" ADD COLUMN "parent_id" INTEGER REFERENCES "edp_posts"("id") ON DELETE SET NULL;
CREATE INDEX IF NOT EXISTS "posts_parent_id_idx" ON "edp_posts" ("parent_id");
