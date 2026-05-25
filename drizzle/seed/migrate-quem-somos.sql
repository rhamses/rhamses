-- Migração Quem Somos (SonicJS -> EdgePress)
-- Legado posttype=quemsomos -> post type page (2 páginas PT/EN)
-- Pré-requisito: seed (page, attachment, locales pt_BR/en_US)
-- meta posttype "quemsomos" mantido para compatibilidade farramedia (GetPage)

-- Quem Somos (0e199125-242f-45d0-8096-a6defaefd022) locale=pt_BR
INSERT OR IGNORE INTO posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='attachment' LIMIT 1), 'banner_quemsomos_desktop_prbr.avif', 'attachment-quemsomos-pt-desktop', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/avif","attachment_file":"banner_quemsomos_desktop_prbr.avif","attachment_path":"https://bucket.farra.media/banner_quemsomos_desktop_prbr.avif","attachment_alt":"Quem Somos"}', 1716340209000, 1722431412905
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='attachment-quemsomos-pt-desktop');
INSERT OR IGNORE INTO posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='attachment' LIMIT 1), 'banner_site_quem-somos_mobile-pt.avif', 'attachment-quemsomos-pt-mobile', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/avif","attachment_file":"banner_site_quem-somos_mobile-pt.avif","attachment_path":"https://bucket.farra.media/banner_site_quem-somos_mobile-pt.avif","attachment_alt":"Quem Somos"}', 1716340209000, 1722431412905
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='attachment-quemsomos-pt-mobile');
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='page' LIMIT 1), (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1), 'Quem Somos', 'quem-somos', '', 'Os sócios André Brandt, Gui Vieira e Gui Cintra acumulam experiências em roteiro, criação, direção, produção e produção executiva de conteúdo e publicidade nos mais renomados players do mercado, como TV Globo, Netflix, Disney, Instagram, Viacom, WarnerBros Discovery, Spotify, RecordTV, Bandeirantes, Globoplay, Amazon Prime Video, ESPN, GNT e Multishow. Soma-se a essa bagagem um time fixo de profissionais de ofícios plurais, garantindo à Farra a entrega de serviços na lógica end-to-end.', 'published', '{"order":0,"image":"https://bucket.farra.media/banner_quemsomos_desktop_prbr.avif","images":"[\"https://bucket.farra.media/banner_site_quem-somos_mobile-pt.avif\"]","language":"ptbr","videos":null,"videosHome":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"quemsomos","legacy_id":"0e199125-242f-45d0-8096-a6defaefd022","legacy_posttype":"quemsomos"}', 1716340209000, 1716340209000, 1722431412905
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='quem-somos');
INSERT OR IGNORE INTO posts_media (post_id, media_id)
SELECT (SELECT id FROM posts WHERE slug='quem-somos' LIMIT 1), (SELECT id FROM posts WHERE slug='attachment-quemsomos-pt-desktop' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='quem-somos') AND EXISTS (SELECT 1 FROM posts WHERE slug='attachment-quemsomos-pt-desktop');
INSERT OR IGNORE INTO posts_media (post_id, media_id)
SELECT (SELECT id FROM posts WHERE slug='quem-somos' LIMIT 1), (SELECT id FROM posts WHERE slug='attachment-quemsomos-pt-mobile' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='quem-somos') AND EXISTS (SELECT 1 FROM posts WHERE slug='attachment-quemsomos-pt-mobile');
UPDATE posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM posts WHERE slug='attachment-quemsomos-pt-desktop' LIMIT 1)) WHERE slug='quem-somos';
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='quem-somos' AND id_locale_code IS NULL;

-- Who We Are (def7f8eb-16c0-4476-ba4c-461fefbdd937) locale=en_US
INSERT OR IGNORE INTO posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='attachment' LIMIT 1), 'banner_quemsomos_desktop_en.avif', 'attachment-quemsomos-en-desktop', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/avif","attachment_file":"banner_quemsomos_desktop_en.avif","attachment_path":"https://bucket.farra.media/banner_quemsomos_desktop_en.avif","attachment_alt":"Who We Are"}', 1716340155186, 1717158813913
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='attachment-quemsomos-en-desktop');
INSERT OR IGNORE INTO posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='attachment' LIMIT 1), 'banner_quemsomos_desktop_en.avif', 'attachment-quemsomos-en-mobile', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/avif","attachment_file":"banner_quemsomos_desktop_en.avif","attachment_path":"https://bucket.farra.media/banner_quemsomos_desktop_en.avif","attachment_alt":"Who We Are"}', 1716340155186, 1717158813913
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='attachment-quemsomos-en-mobile');
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='page' LIMIT 1), (SELECT id FROM locales WHERE locale_code='en_US' LIMIT 1), 'Who We Are', 'who-we-are', '', 'Partners André Brandt, Gui Cintra and Gui Vieira bring together their experiences in scripts, creation, direction, production, executive production in cinema, television and internet, in the most renowned broadcasters and platforms in the country, such as TV Globo, Disney+, Netflix, HBO Max, Amazon Prime Video, GNT, Spotify, RecordTV, Deezer, Globoplay, Multishow, TNT, Band, Redetv!, ESPN, Nickelodeon, National Geographic and Warner Channel.', 'published', '{"order":0,"image":"https://bucket.farra.media/banner_quemsomos_desktop_en.avif","images":"[\"https://bucket.farra.media/banner_quemsomos_desktop_en.avif\"]","language":"enUS","videos":null,"fichaTecnica":[],"socialMedia":null,"posttype":"quemsomos","legacy_id":"def7f8eb-16c0-4476-ba4c-461fefbdd937","legacy_posttype":"quemsomos"}', 1716340155186, 1716340155186, 1717158813913
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='who-we-are');
INSERT OR IGNORE INTO posts_media (post_id, media_id)
SELECT (SELECT id FROM posts WHERE slug='who-we-are' LIMIT 1), (SELECT id FROM posts WHERE slug='attachment-quemsomos-en-desktop' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='who-we-are') AND EXISTS (SELECT 1 FROM posts WHERE slug='attachment-quemsomos-en-desktop');
INSERT OR IGNORE INTO posts_media (post_id, media_id)
SELECT (SELECT id FROM posts WHERE slug='who-we-are' LIMIT 1), (SELECT id FROM posts WHERE slug='attachment-quemsomos-en-mobile' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='who-we-are') AND EXISTS (SELECT 1 FROM posts WHERE slug='attachment-quemsomos-en-mobile');
UPDATE posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM posts WHERE slug='attachment-quemsomos-en-desktop' LIMIT 1)) WHERE slug='who-we-are';
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='who-we-are' AND id_locale_code IS NULL;

UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1)
WHERE post_type_id = (SELECT id FROM post_types WHERE slug='page' LIMIT 1)
  AND json_extract(meta_values, '$.legacy_posttype') = 'quemsomos'
  AND json_extract(meta_values, '$.language') = 'ptbr'
  AND id_locale_code IS NULL;

UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='en_US' LIMIT 1)
WHERE post_type_id = (SELECT id FROM post_types WHERE slug='page' LIMIT 1)
  AND json_extract(meta_values, '$.legacy_posttype') = 'quemsomos'
  AND json_extract(meta_values, '$.language') = 'enUS'
  AND id_locale_code IS NULL;
