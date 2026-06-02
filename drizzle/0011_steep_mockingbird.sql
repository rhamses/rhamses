CREATE TABLE `edp_settings` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` text NOT NULL,
	`value` text NOT NULL,
	`autoload` integer DEFAULT true NOT NULL
);
--> statement-breakpoint
CREATE INDEX `edp_settings_name_idx` ON `edp_settings` (`name`);--> statement-breakpoint
CREATE TABLE `__new_posts` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`post_type_id` integer NOT NULL,
	`author_id` text,
	`title` text NOT NULL,
	`slug` text NOT NULL,
	`excerpt` text,
	`body` text,
	`status` text DEFAULT 'draft',
	`meta_values` text,
	`published_at` integer,
	`created_at` integer,
	`updated_at` integer
);
--> statement-breakpoint
INSERT INTO `__new_posts`("id", "post_type_id", "author_id", "title", "slug", "excerpt", "body", "status", "meta_values", "published_at", "created_at", "updated_at") SELECT "id", "post_type_id", "author_id", "title", "slug", "excerpt", "body", "status", "meta_values", "published_at", "created_at", "updated_at" FROM `edp_posts`;--> statement-breakpoint
DROP TABLE `edp_posts`;--> statement-breakpoint
ALTER TABLE `__new_posts` RENAME TO `edp_posts`;--> statement-breakpoint
CREATE UNIQUE INDEX `edp_posts_slug_unique` ON `edp_posts` (`slug`);--> statement-breakpoint
CREATE INDEX `edp_posts_post_type_id_idx` ON `edp_posts` (`post_type_id`);--> statement-breakpoint
CREATE INDEX `edp_posts_author_id_idx` ON `edp_posts` (`author_id`);--> statement-breakpoint
CREATE INDEX `edp_posts_status_idx` ON `edp_posts` (`status`);--> statement-breakpoint
CREATE INDEX `edp_posts_created_at_idx` ON `edp_posts` (`created_at`);--> statement-breakpoint
CREATE INDEX `edp_posts_updated_at_idx` ON `edp_posts` (`updated_at`);--> statement-breakpoint
CREATE INDEX `edp_posts_slug_idx` ON `edp_posts` (`slug`);--> statement-breakpoint
CREATE TABLE `__new_taxonomies` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`name` text NOT NULL,
	`slug` text NOT NULL,
	`description` text,
	`type` text NOT NULL,
	`parent_id` integer,
	`created_at` integer,
	`updated_at` integer
);
--> statement-breakpoint
INSERT INTO `__new_taxonomies`("id", "name", "slug", "description", "type", "parent_id", "created_at", "updated_at") SELECT "id", "name", "slug", "description", "type", "parent_id", "created_at", "updated_at" FROM `edp_taxonomies`;--> statement-breakpoint
DROP TABLE `edp_taxonomies`;--> statement-breakpoint
ALTER TABLE `__new_taxonomies` RENAME TO `edp_taxonomies`;--> statement-breakpoint
CREATE INDEX `edp_taxonomies_type_idx` ON `edp_taxonomies` (`type`);--> statement-breakpoint
CREATE INDEX `edp_taxonomies_parent_id_idx` ON `edp_taxonomies` (`parent_id`);--> statement-breakpoint
CREATE INDEX `edp_taxonomies_slug_idx` ON `edp_taxonomies` (`slug`);--> statement-breakpoint
CREATE UNIQUE INDEX `edp_taxonomies_type_slug_idx` ON `edp_taxonomies` (`type`,`slug`);--> statement-breakpoint
CREATE TABLE `__new_post_types` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`slug` text NOT NULL,
	`name` text NOT NULL,
	`meta_schema` text DEFAULT '[{"key":"menu_order","type":"number","default":0},{"key":"parent_id","type":"number"},{"key":"show_in_menu","type":"boolean","default":false},{"key":"menu_options","type":"array","default":[]},{"key":"icon","type":"string","default":"line-md:document"},{"key":"post_thumbnail","type":"boolean","default":false}]',
	`created_at` integer,
	`updated_at` integer
);
--> statement-breakpoint
INSERT INTO `__new_post_types`("id", "slug", "name", "meta_schema", "created_at", "updated_at") SELECT "id", "slug", "name", "meta_schema", "created_at", "updated_at" FROM `edp_post_types`;--> statement-breakpoint
DROP TABLE `edp_post_types`;--> statement-breakpoint
ALTER TABLE `__new_post_types` RENAME TO `edp_post_types`;--> statement-breakpoint
CREATE UNIQUE INDEX `edp_post_types_slug_unique` ON `edp_post_types` (`slug`);--> statement-breakpoint
CREATE INDEX `edp_post_types_slug_idx` ON `edp_post_types` (`slug`);--> statement-breakpoint
CREATE TABLE `__new_user` (
	`id` text PRIMARY KEY NOT NULL,
	`name` text NOT NULL,
	`email` text NOT NULL,
	`email_verified` integer DEFAULT false NOT NULL,
	`image` text,
	`role` integer DEFAULT 3,
	`created_at` integer NOT NULL,
	`updated_at` integer NOT NULL
);
--> statement-breakpoint
INSERT INTO `__new_user`("id", "name", "email", "email_verified", "image", "role", "created_at", "updated_at") SELECT "id", "name", "email", "email_verified", "image", "role", "created_at", "updated_at" FROM `edp_user`;--> statement-breakpoint
DROP TABLE `edp_user`;--> statement-breakpoint
ALTER TABLE `__new_user` RENAME TO `edp_user`;--> statement-breakpoint
CREATE UNIQUE INDEX `edp_user_email_unique` ON `edp_user` (`email`);--> statement-breakpoint
CREATE TABLE `__new_posts_media` (
	`post_id` integer NOT NULL,
	`media_id` integer NOT NULL,
	PRIMARY KEY(`post_id`, `media_id`)
);
--> statement-breakpoint
INSERT INTO `__new_posts_media`("post_id", "media_id") SELECT "post_id", "media_id" FROM `edp_posts_media`;--> statement-breakpoint
DROP TABLE `edp_posts_media`;--> statement-breakpoint
ALTER TABLE `__new_posts_media` RENAME TO `edp_posts_media`;--> statement-breakpoint
CREATE INDEX `edp_posts_media_post_id_idx` ON `edp_posts_media` (`post_id`);--> statement-breakpoint
CREATE INDEX `edp_posts_media_media_id_idx` ON `edp_posts_media` (`media_id`);--> statement-breakpoint
CREATE INDEX IF NOT EXISTS `edp_posts_taxonomies_post_id_idx` ON `edp_posts_taxonomies` (`post_id`);--> statement-breakpoint
CREATE INDEX IF NOT EXISTS `edp_posts_taxonomies_term_id_idx` ON `edp_posts_taxonomies` (`term_id`);