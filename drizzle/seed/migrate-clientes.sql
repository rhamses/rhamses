-- Migração clientes (SonicJS -> EdgePress)
-- Post type: post (padrão) + categoria "cliente" em taxonomies
-- 46 clientes com imagem. Pré-requisito: seed (post, attachment, taxonomies categoria, locale pt_BR)
-- meta posttype "clientes" mantido para compatibilidade farramedia

-- Categoria "cliente" filha de "categoria" (type=category)
INSERT OR IGNORE INTO edp_taxonomies (name, slug, type, parent_id, created_at, updated_at)
SELECT 'Cliente', 'cliente', 'category', (SELECT id FROM edp_taxonomies WHERE slug='categoria' LIMIT 1), 0, 0
WHERE NOT EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');

-- AMAZON_PRIME_VIDEO (8d8db12a-a025-4e55-b344-eadd4a0b16b3) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'logo_0005_Amazon_Prime_Video.png', 'attachment-cliente-amazonprimevideo', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"logo_0005_Amazon_Prime_Video.png","attachment_path":"https://bucket.farra.media/logo_0005_Amazon_Prime_Video.png","attachment_alt":"AMAZON_PRIME_VIDEO"}', 1716339675478, 1716339675478
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-amazonprimevideo');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'AMAZON_PRIME_VIDEO', 'amazonprimevideo', 'published', '{"order":0,"image":"https://bucket.farra.media/logo_0005_Amazon_Prime_Video.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"8d8db12a-a025-4e55-b344-eadd4a0b16b3"}', 1716339675478, 1716339675478, 1716339675478
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='amazonprimevideo');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='amazonprimevideo' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-amazonprimevideo' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='amazonprimevideo') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-amazonprimevideo');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='amazonprimevideo' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='amazonprimevideo') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-amazonprimevideo' LIMIT 1)) WHERE slug='amazonprimevideo';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='amazonprimevideo' AND id_locale_code IS NULL;

-- AUDIBLE (ae084bd2-e2c5-4f9b-9757-a8a00d5a22b9) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'audible.png', 'attachment-cliente-audible', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"audible.png","attachment_path":"https://bucket.farra.media/audible.png","attachment_alt":"AUDIBLE"}', 1727809074000, 1768239671057
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-audible');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'AUDIBLE', 'audible', 'published', '{"order":0,"image":"https://bucket.farra.media/audible.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"ae084bd2-e2c5-4f9b-9757-a8a00d5a22b9"}', 1727809074000, 1727809074000, 1768239671057
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='audible');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='audible' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-audible' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='audible') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-audible');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='audible' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='audible') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-audible' LIMIT 1)) WHERE slug='audible';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='audible' AND id_locale_code IS NULL;

-- BAND (b6dac81d-6ffe-4cd2-bc4d-9706e3fe0e78) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'logo_0006_Band.png', 'attachment-cliente-band', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"logo_0006_Band.png","attachment_path":"https://bucket.farra.media/logo_0006_Band.png","attachment_alt":"BAND"}', 1716339299471, 1716339299471
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-band');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'BAND', 'band', 'published', '{"order":0,"image":"https://bucket.farra.media/logo_0006_Band.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"b6dac81d-6ffe-4cd2-bc4d-9706e3fe0e78"}', 1716339299471, 1716339299471, 1716339299471
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='band');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='band' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-band' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='band') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-band');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='band' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='band') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-band' LIMIT 1)) WHERE slug='band';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='band' AND id_locale_code IS NULL;

-- BETC HAVAS (c16760f2-1395-4d80-bf29-827b42848cda) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'Camada-1.png', 'attachment-cliente-betc-havas', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"Camada-1.png","attachment_path":"https://bucket.farra.media/Camada-1.png","attachment_alt":"BETC HAVAS"}', 1716339782378, 1716339782378
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-betc-havas');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'BETC HAVAS', 'betc-havas', 'published', '{"order":0,"image":"https://bucket.farra.media/Camada-1.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"c16760f2-1395-4d80-bf29-827b42848cda"}', 1716339782378, 1716339782378, 1716339782378
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='betc-havas');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='betc-havas' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-betc-havas' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='betc-havas') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-betc-havas');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='betc-havas' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='betc-havas') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-betc-havas' LIMIT 1)) WHERE slug='betc-havas';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='betc-havas' AND id_locale_code IS NULL;

-- CCXP (f2c5ae43-73d4-4308-9035-613a952cc6fa) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'ccxp-logo.png', 'attachment-cliente-ccxp', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"ccxp-logo.png","attachment_path":"https://bucket.farra.media/ccxp-logo.png","attachment_alt":"CCXP"}', 1716339567000, 1719965160690
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-ccxp');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'CCXP', 'ccxp', 'published', '{"order":0,"image":"https://bucket.farra.media/ccxp-logo.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"f2c5ae43-73d4-4308-9035-613a952cc6fa"}', 1716339567000, 1716339567000, 1719965160690
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='ccxp');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='ccxp' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-ccxp' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='ccxp') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-ccxp');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='ccxp' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='ccxp') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-ccxp' LIMIT 1)) WHERE slug='ccxp';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='ccxp' AND id_locale_code IS NULL;

-- COMEDY (9ffa0b59-94b1-43a4-a849-6acb5b5e6eaa) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'comedy-central-650x650.png', 'attachment-cliente-comedy', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"comedy-central-650x650.png","attachment_path":"https://bucket.farra.media/comedy-central-650x650.png","attachment_alt":"COMEDY"}', 1716339527919, 1716339527919
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-comedy');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'COMEDY', 'comedy', 'published', '{"order":0,"image":"https://bucket.farra.media/comedy-central-650x650.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"9ffa0b59-94b1-43a4-a849-6acb5b5e6eaa"}', 1716339527919, 1716339527919, 1716339527919
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='comedy');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='comedy' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-comedy' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='comedy') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-comedy');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='comedy' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='comedy') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-comedy' LIMIT 1)) WHERE slug='comedy';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='comedy' AND id_locale_code IS NULL;

-- DEEZER (df5ba39b-270e-464b-afd5-0371bdfd410d) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'deezer.png', 'attachment-cliente-deezer', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"deezer.png","attachment_path":"https://bucket.farra.media/deezer.png","attachment_alt":"DEEZER"}', 1727809035000, 1768240871383
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-deezer');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'DEEZER', 'deezer', 'published', '{"order":0,"image":"https://bucket.farra.media/deezer.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"df5ba39b-270e-464b-afd5-0371bdfd410d"}', 1727809035000, 1727809035000, 1768240871383
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='deezer');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='deezer' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-deezer' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='deezer') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-deezer');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='deezer' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='deezer') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-deezer' LIMIT 1)) WHERE slug='deezer';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='deezer' AND id_locale_code IS NULL;

-- DISNEY (5d20455d-a6d1-4a94-be9a-a4f0de2f87a1) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'disney.png', 'attachment-cliente-disney', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"disney.png","attachment_path":"https://bucket.farra.media/disney.png","attachment_alt":"DISNEY"}', 1716339649521, 1716339649521
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-disney');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'DISNEY', 'disney', 'published', '{"order":0,"image":"https://bucket.farra.media/disney.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"5d20455d-a6d1-4a94-be9a-a4f0de2f87a1"}', 1716339649521, 1716339649521, 1716339649521
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='disney');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='disney' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-disney' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='disney') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-disney');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='disney' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='disney') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-disney' LIMIT 1)) WHERE slug='disney';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='disney' AND id_locale_code IS NULL;

-- DUDALINA (2ee6f1b8-2ce6-4a19-955a-73a12e7ba9c5) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'dualina.png', 'attachment-cliente-dudalina', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"dualina.png","attachment_path":"https://bucket.farra.media/dualina.png","attachment_alt":"DUDALINA"}', 1727809241000, 1768230145159
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-dudalina');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'DUDALINA', 'dudalina', 'published', '{"order":0,"image":"https://bucket.farra.media/dualina.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"2ee6f1b8-2ce6-4a19-955a-73a12e7ba9c5"}', 1727809241000, 1727809241000, 1768230145159
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='dudalina');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='dudalina' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-dudalina' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='dudalina') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-dudalina');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='dudalina' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='dudalina') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-dudalina' LIMIT 1)) WHERE slug='dudalina';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='dudalina' AND id_locale_code IS NULL;

-- ESPN (4db2e27d-4c2d-4c9c-8af0-2d1b4a04c61b) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'logo_0001_espn.png', 'attachment-cliente-espn', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"logo_0001_espn.png","attachment_path":"https://bucket.farra.media/logo_0001_espn.png","attachment_alt":"ESPN"}', 1716339607396, 1716339607396
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-espn');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'ESPN', 'espn', 'published', '{"order":0,"image":"https://bucket.farra.media/logo_0001_espn.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"4db2e27d-4c2d-4c9c-8af0-2d1b4a04c61b"}', 1716339607396, 1716339607396, 1716339607396
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='espn');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='espn' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-espn' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='espn') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-espn');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='espn' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='espn') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-espn' LIMIT 1)) WHERE slug='espn';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='espn' AND id_locale_code IS NULL;

-- FAMILHÃO (d1eec597-72b6-4c30-8319-77bc49ca732c) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'familhao.png', 'attachment-cliente-familhao', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"familhao.png","attachment_path":"https://bucket.farra.media/familhao.png","attachment_alt":"FAMILH\u00c3O"}', 1727809251000, 1768240825113
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-familhao');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'FAMILHÃO', 'familhao', 'published', '{"order":0,"image":"https://bucket.farra.media/familhao.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"d1eec597-72b6-4c30-8319-77bc49ca732c"}', 1727809251000, 1727809251000, 1768240825113
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='familhao');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='familhao' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-familhao' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='familhao') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-familhao');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='familhao' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='familhao') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-familhao' LIMIT 1)) WHERE slug='familhao';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='familhao' AND id_locale_code IS NULL;

-- FAN FEVER (4ee6e5e1-2bb0-4228-b221-94b85e590268) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'fanfever.png', 'attachment-cliente-fan-fever', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"fanfever.png","attachment_path":"https://bucket.farra.media/fanfever.png","attachment_alt":"FAN FEVER"}', 1727809315000, 1768241237190
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-fan-fever');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'FAN FEVER', 'fan-fever', 'published', '{"order":0,"image":"https://bucket.farra.media/fanfever.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"4ee6e5e1-2bb0-4228-b221-94b85e590268"}', 1727809315000, 1727809315000, 1768241237190
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='fan-fever');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='fan-fever' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-fan-fever' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='fan-fever') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-fan-fever');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='fan-fever' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='fan-fever') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-fan-fever' LIMIT 1)) WHERE slug='fan-fever';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='fan-fever' AND id_locale_code IS NULL;

-- FARFETCH (20672ef4-4fa8-4fe6-878c-a89ff9d0ea23) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'FARFETCH.png', 'attachment-cliente-farfetch', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"FARFETCH.png","attachment_path":"https://bucket.farra.media/FARFETCH.png","attachment_alt":"FARFETCH"}', 1727809480579, 1727809480579
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-farfetch');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'FARFETCH', 'farfetch', 'published', '{"order":0,"image":"https://bucket.farra.media/FARFETCH.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"20672ef4-4fa8-4fe6-878c-a89ff9d0ea23"}', 1727809480579, 1727809480579, 1727809480579
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='farfetch');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='farfetch' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-farfetch' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='farfetch') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-farfetch');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='farfetch' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='farfetch') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-farfetch' LIMIT 1)) WHERE slug='farfetch';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='farfetch' AND id_locale_code IS NULL;

-- GLOBOPLAY (bb0dd846-d5de-4122-b9bb-b7a4f0010b15) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'logo_0000_globoplay.png', 'attachment-cliente-globoplay', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"logo_0000_globoplay.png","attachment_path":"https://bucket.farra.media/logo_0000_globoplay.png","attachment_alt":"GLOBOPLAY"}', 1716339725554, 1716339725554
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-globoplay');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'GLOBOPLAY', 'globoplay', 'published', '{"order":0,"image":"https://bucket.farra.media/logo_0000_globoplay.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"bb0dd846-d5de-4122-b9bb-b7a4f0010b15"}', 1716339725554, 1716339725554, 1716339725554
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='globoplay');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='globoplay' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-globoplay' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='globoplay') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-globoplay');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='globoplay' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='globoplay') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-globoplay' LIMIT 1)) WHERE slug='globoplay';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='globoplay' AND id_locale_code IS NULL;

-- GNT (7ca05596-5da8-454f-a78e-44fec35cfaea) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'logo_0008_GNT.png', 'attachment-cliente-gnt', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"logo_0008_GNT.png","attachment_path":"https://bucket.farra.media/logo_0008_GNT.png","attachment_alt":"GNT"}', 1716339270909, 1716339270909
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-gnt');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'GNT', 'gnt', 'published', '{"order":0,"image":"https://bucket.farra.media/logo_0008_GNT.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"7ca05596-5da8-454f-a78e-44fec35cfaea"}', 1716339270909, 1716339270909, 1716339270909
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='gnt');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='gnt' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-gnt' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='gnt') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-gnt');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='gnt' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='gnt') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-gnt' LIMIT 1)) WHERE slug='gnt';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='gnt' AND id_locale_code IS NULL;

-- HBO (b75d7ed9-34d4-45c4-9a38-ee4cc463956e) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'logo_0016_hbo.png', 'attachment-cliente-hbo', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"logo_0016_hbo.png","attachment_path":"https://bucket.farra.media/logo_0016_hbo.png","attachment_alt":"HBO"}', 1716339746864, 1716339746864
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-hbo');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'HBO', 'hbo', 'published', '{"order":0,"image":"https://bucket.farra.media/logo_0016_hbo.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"b75d7ed9-34d4-45c4-9a38-ee4cc463956e"}', 1716339746864, 1716339746864, 1716339746864
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='hbo');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='hbo' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-hbo' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='hbo') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-hbo');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='hbo' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='hbo') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-hbo' LIMIT 1)) WHERE slug='hbo';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='hbo' AND id_locale_code IS NULL;

-- HEINKEN (14698773-1a19-408d-9421-dc602b868099) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'heinken-650x650.png', 'attachment-cliente-heinken', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"heinken-650x650.png","attachment_path":"https://bucket.farra.media/heinken-650x650.png","attachment_alt":"HEINKEN"}', 1716339842553, 1716339842553
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-heinken');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'HEINKEN', 'heinken', 'published', '{"order":0,"image":"https://bucket.farra.media/heinken-650x650.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"14698773-1a19-408d-9421-dc602b868099"}', 1716339842553, 1716339842553, 1716339842553
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='heinken');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='heinken' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-heinken' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='heinken') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-heinken');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='heinken' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='heinken') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-heinken' LIMIT 1)) WHERE slug='heinken';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='heinken' AND id_locale_code IS NULL;

-- HERBAMED (1413738e-c410-4c52-8d68-b86898941bbc) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'Ativo 1.png', 'attachment-cliente-herbamed', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"Ativo 1.png","attachment_path":"https://bucket.farra.media/Ativo 1.png","attachment_alt":"HERBAMED"}', 1768229315391, 1768229315391
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-herbamed');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'HERBAMED', 'herbamed', 'published', '{"order":0,"image":"https://bucket.farra.media/Ativo 1.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"1413738e-c410-4c52-8d68-b86898941bbc"}', 1768229315391, 1768229315391, 1768229315391
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='herbamed');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='herbamed' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-herbamed' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='herbamed') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-herbamed');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='herbamed' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='herbamed') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-herbamed' LIMIT 1)) WHERE slug='herbamed';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='herbamed' AND id_locale_code IS NULL;

-- ITAU (632b83c0-8415-47c8-8a4f-6a18caa6d1a8) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'itau-650x650.png', 'attachment-cliente-itau', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"itau-650x650.png","attachment_path":"https://bucket.farra.media/itau-650x650.png","attachment_alt":"ITAU"}', 1716340021434, 1716340021434
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-itau');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'ITAU', 'itau', 'published', '{"order":0,"image":"https://bucket.farra.media/itau-650x650.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"632b83c0-8415-47c8-8a4f-6a18caa6d1a8"}', 1716340021434, 1716340021434, 1716340021434
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='itau');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='itau' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-itau' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='itau') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-itau');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='itau' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='itau') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-itau' LIMIT 1)) WHERE slug='itau';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='itau' AND id_locale_code IS NULL;

-- KWAI (2d35ccba-18ca-440a-b7bf-828885707ba3) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'kwai-logo.png', 'attachment-cliente-kwai', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"kwai-logo.png","attachment_path":"https://bucket.farra.media/kwai-logo.png","attachment_alt":"KWAI"}', 1716339561000, 1719965254682
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-kwai');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'KWAI', 'kwai', 'published', '{"order":0,"image":"https://bucket.farra.media/kwai-logo.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"2d35ccba-18ca-440a-b7bf-828885707ba3"}', 1716339561000, 1716339561000, 1719965254682
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='kwai');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='kwai' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-kwai' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='kwai') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-kwai');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='kwai' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='kwai') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-kwai' LIMIT 1)) WHERE slug='kwai';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='kwai' AND id_locale_code IS NULL;

-- LIVELO (c3e18558-5ba6-49c8-819b-f476775216be) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'kivelo.png', 'attachment-cliente-livelo', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"kivelo.png","attachment_path":"https://bucket.farra.media/kivelo.png","attachment_alt":"LIVELO"}', 1727809217000, 1768239791837
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-livelo');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'LIVELO', 'livelo', 'published', '{"order":0,"image":"https://bucket.farra.media/kivelo.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"c3e18558-5ba6-49c8-819b-f476775216be"}', 1727809217000, 1727809217000, 1768239791837
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='livelo');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='livelo' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-livelo' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='livelo') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-livelo');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='livelo' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='livelo') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-livelo' LIMIT 1)) WHERE slug='livelo';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='livelo' AND id_locale_code IS NULL;

-- LOGITECH (19c5f82b-7879-4c8d-b820-ed0a83337c49) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'LOGITECH.png', 'attachment-cliente-logitech', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"LOGITECH.png","attachment_path":"https://bucket.farra.media/LOGITECH.png","attachment_alt":"LOGITECH"}', 1727808909011, 1727808909011
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-logitech');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'LOGITECH', 'logitech', 'published', '{"order":0,"image":"https://bucket.farra.media/LOGITECH.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"19c5f82b-7879-4c8d-b820-ed0a83337c49"}', 1727808909011, 1727808909011, 1727808909011
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='logitech');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='logitech' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-logitech' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='logitech') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-logitech');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='logitech' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='logitech') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-logitech' LIMIT 1)) WHERE slug='logitech';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='logitech' AND id_locale_code IS NULL;

-- MIBR (140707ca-524c-4239-bb98-8b12fca0503b) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'mibr.png', 'attachment-cliente-mibr', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"mibr.png","attachment_path":"https://bucket.farra.media/mibr.png","attachment_alt":"MIBR"}', 1716339385654, 1716339385654
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-mibr');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'MIBR', 'mibr', 'published', '{"order":0,"image":"https://bucket.farra.media/mibr.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"140707ca-524c-4239-bb98-8b12fca0503b"}', 1716339385654, 1716339385654, 1716339385654
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='mibr');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='mibr' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-mibr' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='mibr') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-mibr');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='mibr' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='mibr') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-mibr' LIMIT 1)) WHERE slug='mibr';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='mibr' AND id_locale_code IS NULL;

-- MULTISHOW (8e27f73e-a24c-4219-9385-625506625e10) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'logo_0014_multishow.png', 'attachment-cliente-multishow', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"logo_0014_multishow.png","attachment_path":"https://bucket.farra.media/logo_0014_multishow.png","attachment_alt":"MULTISHOW"}', 1716339234074, 1716339234074
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-multishow');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'MULTISHOW', 'multishow', 'published', '{"order":0,"image":"https://bucket.farra.media/logo_0014_multishow.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"8e27f73e-a24c-4219-9385-625506625e10"}', 1716339234074, 1716339234074, 1716339234074
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='multishow');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='multishow' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-multishow' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='multishow') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-multishow');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='multishow' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='multishow') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-multishow' LIMIT 1)) WHERE slug='multishow';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='multishow' AND id_locale_code IS NULL;

-- Merz (12106581-9eff-49ad-a36f-391d46089d4d) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'merz.png', 'attachment-cliente-merz', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"merz.png","attachment_path":"https://bucket.farra.media/merz.png","attachment_alt":"Merz"}', 1768229636587, 1768229636587
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-merz');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'Merz', 'merz', 'published', '{"order":0,"image":"https://bucket.farra.media/merz.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"12106581-9eff-49ad-a36f-391d46089d4d"}', 1768229636587, 1768229636587, 1768229636587
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='merz');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='merz' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-merz' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='merz') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-merz');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='merz' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='merz') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-merz' LIMIT 1)) WHERE slug='merz';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='merz' AND id_locale_code IS NULL;

-- NATURA (cd1e21c2-d551-49c4-a745-c1dc5662303f) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'NATURA.png', 'attachment-cliente-natura', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"NATURA.png","attachment_path":"https://bucket.farra.media/NATURA.png","attachment_alt":"NATURA"}', 1716339791152, 1716339791152
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-natura');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'NATURA', 'natura', 'published', '{"order":0,"image":"https://bucket.farra.media/NATURA.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"cd1e21c2-d551-49c4-a745-c1dc5662303f"}', 1716339791152, 1716339791152, 1716339791152
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='natura');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='natura' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-natura' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='natura') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-natura');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='natura' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='natura') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-natura' LIMIT 1)) WHERE slug='natura';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='natura' AND id_locale_code IS NULL;

-- NETFLIX (c002dc27-823f-43f4-9603-6d32a82058d6) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'logo_0003_Netflix.png', 'attachment-cliente-netflix', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"logo_0003_Netflix.png","attachment_path":"https://bucket.farra.media/logo_0003_Netflix.png","attachment_alt":"NETFLIX"}', 1716339909013, 1716339909013
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-netflix');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'NETFLIX', 'netflix', 'published', '{"order":0,"image":"https://bucket.farra.media/logo_0003_Netflix.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"c002dc27-823f-43f4-9603-6d32a82058d6"}', 1716339909013, 1716339909013, 1716339909013
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='netflix');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='netflix' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-netflix' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='netflix') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-netflix');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='netflix' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='netflix') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-netflix' LIMIT 1)) WHERE slug='netflix';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='netflix' AND id_locale_code IS NULL;

-- Natgeo (2379d187-bba6-4c3f-8003-e2a7bc3c7b3d) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'national ge.png', 'attachment-cliente-natgeo', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"national ge.png","attachment_path":"https://bucket.farra.media/national ge.png","attachment_alt":"Natgeo"}', 1727808499000, 1768241283845
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-natgeo');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'Natgeo', 'natgeo', 'published', '{"order":0,"image":"https://bucket.farra.media/national ge.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"2379d187-bba6-4c3f-8003-e2a7bc3c7b3d"}', 1727808499000, 1727808499000, 1768241283845
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='natgeo');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='natgeo' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-natgeo' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='natgeo') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-natgeo');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='natgeo' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='natgeo') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-natgeo' LIMIT 1)) WHERE slug='natgeo';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='natgeo' AND id_locale_code IS NULL;

-- Nubank (b842ad1b-6a7b-4a57-b169-391760abb9f7) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'Ativo 2 (3).png', 'attachment-cliente-nubank', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"Ativo 2 (3).png","attachment_path":"https://bucket.farra.media/Ativo 2 (3).png","attachment_alt":"Nubank"}', 1768229506000, 1768239860875
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-nubank');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'Nubank', 'nubank', 'published', '{"order":0,"image":"https://bucket.farra.media/Ativo 2 (3).png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"b842ad1b-6a7b-4a57-b169-391760abb9f7"}', 1768229506000, 1768229506000, 1768239860875
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='nubank');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='nubank' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-nubank' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='nubank') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-nubank');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='nubank' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='nubank') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-nubank' LIMIT 1)) WHERE slug='nubank';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='nubank' AND id_locale_code IS NULL;

-- OMELETE (3164b45a-e8c8-493d-9573-a2115e7d05ce) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'omelete.png', 'attachment-cliente-omelete', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"omelete.png","attachment_path":"https://bucket.farra.media/omelete.png","attachment_alt":"OMELETE"}', 1716339540081, 1716339540081
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-omelete');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'OMELETE', 'omelete', 'published', '{"order":0,"image":"https://bucket.farra.media/omelete.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"3164b45a-e8c8-493d-9573-a2115e7d05ce"}', 1716339540081, 1716339540081, 1716339540081
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='omelete');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='omelete' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-omelete' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='omelete') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-omelete');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='omelete' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='omelete') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-omelete' LIMIT 1)) WHERE slug='omelete';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='omelete' AND id_locale_code IS NULL;

-- OPEN AI (ee3e2e8f-bcb5-4922-8af9-25650ab27b6c) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'OPEN.png', 'attachment-cliente-open-ai', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"OPEN.png","attachment_path":"https://bucket.farra.media/OPEN.png","attachment_alt":"OPEN AI"}', 1768229217641, 1768229217641
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-open-ai');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'OPEN AI', 'open-ai', 'published', '{"order":0,"image":"https://bucket.farra.media/OPEN.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"ee3e2e8f-bcb5-4922-8af9-25650ab27b6c"}', 1768229217641, 1768229217641, 1768229217641
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='open-ai');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='open-ai' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-open-ai' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='open-ai') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-open-ai');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='open-ai' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='open-ai') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-open-ai' LIMIT 1)) WHERE slug='open-ai';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='open-ai' AND id_locale_code IS NULL;

-- Paramount (32394835-fba9-4ac6-9b3c-73704cf35173) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'paramount.png', 'attachment-cliente-paramount', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"paramount.png","attachment_path":"https://bucket.farra.media/paramount.png","attachment_alt":"Paramount"}', 1727808696705, 1727808696705
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-paramount');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'Paramount', 'paramount', 'published', '{"order":0,"image":"https://bucket.farra.media/paramount.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"32394835-fba9-4ac6-9b3c-73704cf35173"}', 1727808696705, 1727808696705, 1727808696705
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='paramount');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='paramount' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-paramount' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='paramount') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-paramount');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='paramount' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='paramount') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-paramount' LIMIT 1)) WHERE slug='paramount';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='paramount' AND id_locale_code IS NULL;

-- Porta dos Fundos (0f38c7ee-f298-4df7-a515-3c75a5442d1a) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'logo-porta-large.png', 'attachment-cliente-porta-dos-fundos', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"logo-porta-large.png","attachment_path":"https://bucket.farra.media/logo-porta-large.png","attachment_alt":"Porta dos Fundos"}', 1716339369406, 1716339369406
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-porta-dos-fundos');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'Porta dos Fundos', 'porta-dos-fundos', 'published', '{"order":0,"image":"https://bucket.farra.media/logo-porta-large.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"0f38c7ee-f298-4df7-a515-3c75a5442d1a"}', 1716339369406, 1716339369406, 1716339369406
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='porta-dos-fundos');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='porta-dos-fundos' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-porta-dos-fundos' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='porta-dos-fundos') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-porta-dos-fundos');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='porta-dos-fundos' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='porta-dos-fundos') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-porta-dos-fundos' LIMIT 1)) WHERE slug='porta-dos-fundos';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='porta-dos-fundos' AND id_locale_code IS NULL;

-- RECORDTV (6ee77380-00e1-4064-bccf-b86506f9ce3d) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'logo_0011_recordtv.png', 'attachment-cliente-recordtv', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"logo_0011_recordtv.png","attachment_path":"https://bucket.farra.media/logo_0011_recordtv.png","attachment_alt":"RECORDTV"}', 1716339293640, 1716339293640
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-recordtv');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'RECORDTV', 'recordtv', 'published', '{"order":0,"image":"https://bucket.farra.media/logo_0011_recordtv.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"6ee77380-00e1-4064-bccf-b86506f9ce3d"}', 1716339293640, 1716339293640, 1716339293640
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='recordtv');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='recordtv' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-recordtv' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='recordtv') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-recordtv');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='recordtv' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='recordtv') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-recordtv' LIMIT 1)) WHERE slug='recordtv';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='recordtv' AND id_locale_code IS NULL;

-- REDETV (5e328d54-728a-4c7b-8e6b-d23717c2d69c) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'logo_0015_RedeTV.png', 'attachment-cliente-redetv', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"logo_0015_RedeTV.png","attachment_path":"https://bucket.farra.media/logo_0015_RedeTV.png","attachment_alt":"REDETV"}', 1716339355354, 1716339355354
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-redetv');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'REDETV', 'redetv', 'published', '{"order":0,"image":"https://bucket.farra.media/logo_0015_RedeTV.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"5e328d54-728a-4c7b-8e6b-d23717c2d69c"}', 1716339355354, 1716339355354, 1716339355354
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='redetv');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='redetv' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-redetv' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='redetv') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-redetv');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='redetv' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='redetv') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-redetv' LIMIT 1)) WHERE slug='redetv';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='redetv' AND id_locale_code IS NULL;

-- RENNOVA (e259afea-b0a6-4a70-9a3d-f8222d44093c) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'rennova.png', 'attachment-cliente-rennova', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"rennova.png","attachment_path":"https://bucket.farra.media/rennova.png","attachment_alt":"RENNOVA"}', 1727808989000, 1768239421668
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-rennova');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'RENNOVA', 'rennova', 'published', '{"order":0,"image":"https://bucket.farra.media/rennova.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"e259afea-b0a6-4a70-9a3d-f8222d44093c"}', 1727808989000, 1727808989000, 1768239421668
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='rennova');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='rennova' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-rennova' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='rennova') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-rennova');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='rennova' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='rennova') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-rennova' LIMIT 1)) WHERE slug='rennova';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='rennova' AND id_locale_code IS NULL;

-- SHEIN (e9d46e53-ea42-425e-a7d5-c96ba1bc7c33) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'shein.png', 'attachment-cliente-shein', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"shein.png","attachment_path":"https://bucket.farra.media/shein.png","attachment_alt":"SHEIN"}', 1727809227000, 1768241203396
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-shein');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'SHEIN', 'shein', 'published', '{"order":0,"image":"https://bucket.farra.media/shein.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"e9d46e53-ea42-425e-a7d5-c96ba1bc7c33"}', 1727809227000, 1727809227000, 1768241203396
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='shein');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='shein' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-shein' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='shein') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-shein');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='shein' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='shein') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-shein' LIMIT 1)) WHERE slug='shein';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='shein' AND id_locale_code IS NULL;

-- SHOPTIME (d1cec8ba-bad6-4992-95b6-bceed68d6216) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'shoptime-650x650.png', 'attachment-cliente-shoptime', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"shoptime-650x650.png","attachment_path":"https://bucket.farra.media/shoptime-650x650.png","attachment_alt":"SHOPTIME"}', 1716339738148, 1716339738148
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-shoptime');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'SHOPTIME', 'shoptime', 'published', '{"order":0,"image":"https://bucket.farra.media/shoptime-650x650.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"d1cec8ba-bad6-4992-95b6-bceed68d6216"}', 1716339738148, 1716339738148, 1716339738148
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='shoptime');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='shoptime' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-shoptime' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='shoptime') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-shoptime');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='shoptime' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='shoptime') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-shoptime' LIMIT 1)) WHERE slug='shoptime';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='shoptime' AND id_locale_code IS NULL;

-- SPOTIFY (9c8b989e-4e24-49a9-b90b-50703869d1ee) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'logo_0010_Spotify.png', 'attachment-cliente-spotify', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"logo_0010_Spotify.png","attachment_path":"https://bucket.farra.media/logo_0010_Spotify.png","attachment_alt":"SPOTIFY"}', 1716339801565, 1716339801565
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-spotify');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'SPOTIFY', 'spotify', 'published', '{"order":0,"image":"https://bucket.farra.media/logo_0010_Spotify.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"9c8b989e-4e24-49a9-b90b-50703869d1ee"}', 1716339801565, 1716339801565, 1716339801565
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='spotify');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='spotify' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-spotify' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='spotify') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-spotify');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='spotify' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='spotify') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-spotify' LIMIT 1)) WHERE slug='spotify';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='spotify' AND id_locale_code IS NULL;

-- STAR (d7aab7c8-672e-49d4-b95d-05c56b4f8dfe) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'star-logo.png', 'attachment-cliente-star', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"star-logo.png","attachment_path":"https://bucket.farra.media/star-logo.png","attachment_alt":"STAR"}', 1716339457000, 1719965291944
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-star');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'STAR', 'star', 'published', '{"order":0,"image":"https://bucket.farra.media/star-logo.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"d7aab7c8-672e-49d4-b95d-05c56b4f8dfe"}', 1716339457000, 1716339457000, 1719965291944
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='star');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='star' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-star' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='star') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-star');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='star' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='star') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-star' LIMIT 1)) WHERE slug='star';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='star' AND id_locale_code IS NULL;

-- TAG (4f0a4bf3-d722-483f-b2c4-f6863947bff4) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'tag-650x650.png', 'attachment-cliente-tag', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"tag-650x650.png","attachment_path":"https://bucket.farra.media/tag-650x650.png","attachment_alt":"TAG"}', 1716339495933, 1716339495933
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-tag');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'TAG', 'tag', 'published', '{"order":0,"image":"https://bucket.farra.media/tag-650x650.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"4f0a4bf3-d722-483f-b2c4-f6863947bff4"}', 1716339495933, 1716339495933, 1716339495933
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='tag');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='tag' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-tag' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='tag') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-tag');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='tag' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='tag') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-tag' LIMIT 1)) WHERE slug='tag';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='tag' AND id_locale_code IS NULL;

-- TIKTOK (ea08490f-44ca-4666-9ac8-a444bee7e15e) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'tiktok-logo-9-1-650x650.png', 'attachment-cliente-tiktok', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"tiktok-logo-9-1-650x650.png","attachment_path":"https://bucket.farra.media/tiktok-logo-9-1-650x650.png","attachment_alt":"TIKTOK"}', 1716339980521, 1716339980521
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-tiktok');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'TIKTOK', 'tiktok', 'published', '{"order":0,"image":"https://bucket.farra.media/tiktok-logo-9-1-650x650.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"ea08490f-44ca-4666-9ac8-a444bee7e15e"}', 1716339980521, 1716339980521, 1716339980521
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='tiktok');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='tiktok' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-tiktok' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='tiktok') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-tiktok');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='tiktok' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='tiktok') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-tiktok' LIMIT 1)) WHERE slug='tiktok';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='tiktok' AND id_locale_code IS NULL;

-- TIM (e3432464-8f43-4f58-b941-5b9ecf3897bd) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'tim-650x650.png', 'attachment-cliente-tim', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"tim-650x650.png","attachment_path":"https://bucket.farra.media/tim-650x650.png","attachment_alt":"TIM"}', 1716339969398, 1716339969398
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-tim');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'TIM', 'tim', 'published', '{"order":0,"image":"https://bucket.farra.media/tim-650x650.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"e3432464-8f43-4f58-b941-5b9ecf3897bd"}', 1716339969398, 1716339969398, 1716339969398
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='tim');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='tim' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-tim' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='tim') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-tim');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='tim' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='tim') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-tim' LIMIT 1)) WHERE slug='tim';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='tim' AND id_locale_code IS NULL;

-- TNT (105cbde2-f5b6-47a0-97b2-57fc2c1beb46) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'Ativo 3 (2).png', 'attachment-cliente-tnt', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"Ativo 3 (2).png","attachment_path":"https://bucket.farra.media/Ativo 3 (2).png","attachment_alt":"TNT"}', 1727808791000, 1768240844261
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-tnt');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'TNT', 'tnt', 'published', '{"order":0,"image":"https://bucket.farra.media/Ativo 3 (2).png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"105cbde2-f5b6-47a0-97b2-57fc2c1beb46"}', 1727808791000, 1727808791000, 1768240844261
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='tnt');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='tnt' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-tnt' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='tnt') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-tnt');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='tnt' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='tnt') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-tnt' LIMIT 1)) WHERE slug='tnt';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='tnt' AND id_locale_code IS NULL;

-- TV GLOBO (20c33bbc-2c8f-4c7c-8150-ddee23b8c778) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'Ativo 2 (2).png', 'attachment-cliente-tv-globo', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"Ativo 2 (2).png","attachment_path":"https://bucket.farra.media/Ativo 2 (2).png","attachment_alt":"TV GLOBO"}', 1767623693000, 1768229007450
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-tv-globo');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'TV GLOBO', 'tv-globo', 'published', '{"order":0,"image":"https://bucket.farra.media/Ativo 2 (2).png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"20c33bbc-2c8f-4c7c-8150-ddee23b8c778"}', 1767623693000, 1767623693000, 1768229007450
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='tv-globo');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='tv-globo' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-tv-globo' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='tv-globo') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-tv-globo');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='tv-globo' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='tv-globo') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-tv-globo' LIMIT 1)) WHERE slug='tv-globo';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='tv-globo' AND id_locale_code IS NULL;

-- WARNER_CHANNEL (6b50b62d-84a8-4c6d-97c4-3320e9d87ea8) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'logo_0007_Warner_Channel.png', 'attachment-cliente-warnerchannel', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"logo_0007_Warner_Channel.png","attachment_path":"https://bucket.farra.media/logo_0007_Warner_Channel.png","attachment_alt":"WARNER_CHANNEL"}', 1716339700232, 1716339700232
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-warnerchannel');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'WARNER_CHANNEL', 'warnerchannel', 'published', '{"order":0,"image":"https://bucket.farra.media/logo_0007_Warner_Channel.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"clientes","legacy_id":"6b50b62d-84a8-4c6d-97c4-3320e9d87ea8"}', 1716339700232, 1716339700232, 1716339700232
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='warnerchannel');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='warnerchannel' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-cliente-warnerchannel' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='warnerchannel') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-cliente-warnerchannel');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='warnerchannel' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='warnerchannel') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='cliente' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-cliente-warnerchannel' LIMIT 1)) WHERE slug='warnerchannel';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='warnerchannel' AND id_locale_code IS NULL;

-- Garante categoria cliente e locale pt_BR em posts migrados
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT p.id, (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
FROM edp_posts p
INNER JOIN edp_post_types pt ON pt.id = p.post_type_id AND pt.slug = 'post'
WHERE json_extract(p.meta_values, '$.posttype') = 'clientes'
  AND json_extract(p.meta_values, '$.legacy_id') IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM edp_posts_taxonomies px WHERE px.post_id = p.id
      AND px.term_id = (SELECT id FROM edp_taxonomies WHERE slug='cliente' AND type='category' LIMIT 1)
  );

UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1)
WHERE post_type_id = (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1)
  AND json_extract(meta_values, '$.posttype') = 'clientes'
  AND json_extract(meta_values, '$.legacy_id') IS NOT NULL
  AND id_locale_code IS NULL;