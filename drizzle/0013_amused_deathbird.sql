ALTER TABLE `edp_taxonomies` ADD `id_locale_code` integer REFERENCES edp_locales(id);--> statement-breakpoint
CREATE INDEX `edp_taxonomies_id_locale_code_idx` ON `edp_taxonomies` (`id_locale_code`);