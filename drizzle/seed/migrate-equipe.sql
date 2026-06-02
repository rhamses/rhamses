-- Migração Equipe (SonicJS -> EdgePress)
-- Post type: post + categoria "equipe" (type=category)
-- 26 membros PT/EN com imagem. Pré-requisito: seed (post, attachment, taxonomies categoria, locales pt_BR/en_US)
-- meta posttype "equipe" mantido para compatibilidade farramedia (GetContent)

-- Categoria "equipe" filha de "categoria"
INSERT OR IGNORE INTO edp_taxonomies (name, slug, type, parent_id, created_at, updated_at)
SELECT 'Equipe', 'equipe', 'category', (SELECT id FROM edp_taxonomies WHERE slug='categoria' LIMIT 1), 0, 0
WHERE NOT EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');

-- Andressa Souza (288afeec-c15a-482f-8136-618ae221edf7) locale=en_US
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'dessa.png', 'attachment-equipe-andressa-souza-en-us', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"dessa.png","attachment_path":"https://bucket.farra.media/dessa.png","attachment_alt":"Andressa Souza"}', 1716341933000, 1749670770085
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-andressa-souza-en-us');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1), 'Andressa Souza', 'andressa-souza-en-us', '', 'Finance manager', 'published', '{"order":0,"image":"https://bucket.farra.media/dessa.png","language":"enUS","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"equipe","legacy_id":"288afeec-c15a-482f-8136-618ae221edf7","legacy_posttype":"equipe"}', 1716341933000, 1716341933000, 1749670770085
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='andressa-souza-en-us');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='andressa-souza-en-us' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-andressa-souza-en-us' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='andressa-souza-en-us') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-andressa-souza-en-us');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='andressa-souza-en-us' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='andressa-souza-en-us') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-andressa-souza-en-us' LIMIT 1)) WHERE slug='andressa-souza-en-us';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='andressa-souza-en-us' AND id_locale_code IS NULL;

-- Andressa Souza (3aa50db0-1279-4471-aefc-a11da2db4810) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'dessa.png', 'attachment-equipe-andressa-souza-pt-br', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"dessa.png","attachment_path":"https://bucket.farra.media/dessa.png","attachment_alt":"Andressa Souza"}', 1716341958000, 1749670736293
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-andressa-souza-pt-br');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'Andressa Souza', 'andressa-souza-pt-br', '', 'Financeiro', 'published', '{"order":0,"image":"https://bucket.farra.media/dessa.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"equipe","legacy_id":"3aa50db0-1279-4471-aefc-a11da2db4810","legacy_posttype":"equipe"}', 1716341958000, 1716341958000, 1749670736293
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='andressa-souza-pt-br');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='andressa-souza-pt-br' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-andressa-souza-pt-br' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='andressa-souza-pt-br') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-andressa-souza-pt-br');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='andressa-souza-pt-br' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='andressa-souza-pt-br') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-andressa-souza-pt-br' LIMIT 1)) WHERE slug='andressa-souza-pt-br';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='andressa-souza-pt-br' AND id_locale_code IS NULL;

-- André Brandt (404cda5f-81b2-494e-a118-6e0e9624c0f1) locale=en_US
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'andre.avif', 'attachment-equipe-andre-brandt-en-us', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/avif","attachment_file":"andre.avif","attachment_path":"https://bucket.farra.media/andre.avif","attachment_alt":"Andr\u00e9 Brandt"}', 1716342362964, 1716342362964
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-andre-brandt-en-us');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1), 'André Brandt', 'andre-brandt-en-us', '', 'Writer, director and partner', 'published', '{"order":0,"image":"https://bucket.farra.media/andre.avif","language":"enUS","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":["https://www.linkedin.com/in/andr%C3%A9-brandt-4294286b/","https://www.instagram.com/brandtandre","https://twitter.com/andrebrandt"],"reel":null,"posttype":"equipe","legacy_id":"404cda5f-81b2-494e-a118-6e0e9624c0f1","legacy_posttype":"equipe"}', 1716342362964, 1716342362964, 1716342362964
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='andre-brandt-en-us');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='andre-brandt-en-us' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-andre-brandt-en-us' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='andre-brandt-en-us') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-andre-brandt-en-us');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='andre-brandt-en-us' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='andre-brandt-en-us') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-andre-brandt-en-us' LIMIT 1)) WHERE slug='andre-brandt-en-us';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='andre-brandt-en-us' AND id_locale_code IS NULL;

-- André Brandt (86838873-8331-4066-8235-38025a3cf1c6) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'andre.avif', 'attachment-equipe-andre-brandt-pt-br', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/avif","attachment_file":"andre.avif","attachment_path":"https://bucket.farra.media/andre.avif","attachment_alt":"Andr\u00e9 Brandt"}', 1716342340055, 1716342340055
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-andre-brandt-pt-br');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'André Brandt', 'andre-brandt-pt-br', '', 'Sócio, diretor e roteirista', 'published', '{"order":0,"image":"https://bucket.farra.media/andre.avif","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":["https://www.linkedin.com/in/andr%C3%A9-brandt-4294286b/","https://www.instagram.com/brandtandre","https://twitter.com/andrebrandt"],"reel":null,"posttype":"equipe","legacy_id":"86838873-8331-4066-8235-38025a3cf1c6","legacy_posttype":"equipe"}', 1716342340055, 1716342340055, 1716342340055
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='andre-brandt-pt-br');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='andre-brandt-pt-br' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-andre-brandt-pt-br' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='andre-brandt-pt-br') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-andre-brandt-pt-br');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='andre-brandt-pt-br' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='andre-brandt-pt-br') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-andre-brandt-pt-br' LIMIT 1)) WHERE slug='andre-brandt-pt-br';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='andre-brandt-pt-br' AND id_locale_code IS NULL;

-- Beatriz Vidal (d9a00bcd-8daf-4a30-99c4-55dc439f9f10) locale=en_US
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'Prancheta 1.png', 'attachment-equipe-beatriz-vidal-en-us', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"Prancheta 1.png","attachment_path":"https://bucket.farra.media/Prancheta 1.png","attachment_alt":"Beatriz Vidal"}', 1716341068000, 1749666372569
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-beatriz-vidal-en-us');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1), 'Beatriz Vidal', 'beatriz-vidal-en-us', '', 'Art director', 'published', '{"order":0,"image":"https://bucket.farra.media/Prancheta 1.png","language":"enUS","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"equipe","legacy_id":"d9a00bcd-8daf-4a30-99c4-55dc439f9f10","legacy_posttype":"equipe"}', 1716341068000, 1716341068000, 1749666372569
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='beatriz-vidal-en-us');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='beatriz-vidal-en-us' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-beatriz-vidal-en-us' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='beatriz-vidal-en-us') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-beatriz-vidal-en-us');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='beatriz-vidal-en-us' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='beatriz-vidal-en-us') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-beatriz-vidal-en-us' LIMIT 1)) WHERE slug='beatriz-vidal-en-us';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='beatriz-vidal-en-us' AND id_locale_code IS NULL;

-- Beatriz Vidal (ba373aa7-c483-4ec0-b037-655be036c9c8) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'Prancheta 1.png', 'attachment-equipe-beatriz-vidal-pt-br', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"Prancheta 1.png","attachment_path":"https://bucket.farra.media/Prancheta 1.png","attachment_alt":"Beatriz Vidal"}', 1716341122000, 1749666481662
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-beatriz-vidal-pt-br');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'Beatriz Vidal', 'beatriz-vidal-pt-br', '', 'Direção de Arte', 'published', '{"order":0,"image":"https://bucket.farra.media/Prancheta 1.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"equipe","legacy_id":"ba373aa7-c483-4ec0-b037-655be036c9c8","legacy_posttype":"equipe"}', 1716341122000, 1716341122000, 1749666481662
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='beatriz-vidal-pt-br');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='beatriz-vidal-pt-br' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-beatriz-vidal-pt-br' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='beatriz-vidal-pt-br') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-beatriz-vidal-pt-br');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='beatriz-vidal-pt-br' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='beatriz-vidal-pt-br') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-beatriz-vidal-pt-br' LIMIT 1)) WHERE slug='beatriz-vidal-pt-br';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='beatriz-vidal-pt-br' AND id_locale_code IS NULL;

-- Fred Kesselring (11712442-b067-400f-a408-388d7cfdc956) locale=en_US
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'Fotos_Quem Somos_Site.png', 'attachment-equipe-fred-kesselring-en-us', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"Fotos_Quem Somos_Site.png","attachment_path":"https://bucket.farra.media/Fotos_Quem Somos_Site.png","attachment_alt":"Fred Kesselring"}', 1727800019000, 1749670586903
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-fred-kesselring-en-us');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1), 'Fred Kesselring', 'fred-kesselring-en-us', '', 'Finisher Editor', 'published', '{"order":0,"image":"https://bucket.farra.media/Fotos_Quem Somos_Site.png","language":"enUS","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"equipe","legacy_id":"11712442-b067-400f-a408-388d7cfdc956","legacy_posttype":"equipe"}', 1727800019000, 1727800019000, 1749670586903
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='fred-kesselring-en-us');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='fred-kesselring-en-us' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-fred-kesselring-en-us' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='fred-kesselring-en-us') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-fred-kesselring-en-us');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='fred-kesselring-en-us' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='fred-kesselring-en-us') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-fred-kesselring-en-us' LIMIT 1)) WHERE slug='fred-kesselring-en-us';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='fred-kesselring-en-us' AND id_locale_code IS NULL;

-- Fred Kesselring (5a7e679c-a907-46ca-8c62-e65866470fd6) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'Fotos_Quem Somos_Site.png', 'attachment-equipe-fred-kesselring-pt-br', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"Fotos_Quem Somos_Site.png","attachment_path":"https://bucket.farra.media/Fotos_Quem Somos_Site.png","attachment_alt":"Fred Kesselring"}', 1727799882000, 1749670660383
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-fred-kesselring-pt-br');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'Fred Kesselring', 'fred-kesselring-pt-br', '', 'Finalizador', 'published', '{"order":0,"image":"https://bucket.farra.media/Fotos_Quem Somos_Site.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"equipe","legacy_id":"5a7e679c-a907-46ca-8c62-e65866470fd6","legacy_posttype":"equipe"}', 1727799882000, 1727799882000, 1749670660383
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='fred-kesselring-pt-br');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='fred-kesselring-pt-br' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-fred-kesselring-pt-br' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='fred-kesselring-pt-br') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-fred-kesselring-pt-br');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='fred-kesselring-pt-br' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='fred-kesselring-pt-br') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-fred-kesselring-pt-br' LIMIT 1)) WHERE slug='fred-kesselring-pt-br';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='fred-kesselring-pt-br' AND id_locale_code IS NULL;

-- Gui Cintra (77af8382-14b4-4e1e-af9f-7defee619c6a) locale=en_US
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'cintra.avif', 'attachment-equipe-gui-cintra-en-us', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/avif","attachment_file":"cintra.avif","attachment_path":"https://bucket.farra.media/cintra.avif","attachment_alt":"Gui Cintra"}', 1726602973000, 1726603120067
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-gui-cintra-en-us');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1), 'Gui Cintra', 'gui-cintra-en-us', '', 'Writer, director and partner', 'published', '{"order":0,"image":"https://bucket.farra.media/cintra.avif","language":"enUS","videos":"1e56330a-f375-4fbd-bcfc-b9a26bc32589","videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":["https://www.linkedin.com/in/guicintra","https://www.instagram.com/cintra/","https://twitter.com/guicintra"],"reel":null,"posttype":"equipe","legacy_id":"77af8382-14b4-4e1e-af9f-7defee619c6a","legacy_posttype":"equipe"}', 1726602973000, 1726602973000, 1726603120067
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='gui-cintra-en-us');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='gui-cintra-en-us' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-gui-cintra-en-us' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='gui-cintra-en-us') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-gui-cintra-en-us');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='gui-cintra-en-us' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='gui-cintra-en-us') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-gui-cintra-en-us' LIMIT 1)) WHERE slug='gui-cintra-en-us';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='gui-cintra-en-us' AND id_locale_code IS NULL;

-- Gui Cintra (a0ae5b15-339a-477a-befb-4989e2381336) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'cintra.avif', 'attachment-equipe-gui-cintra-pt-br', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/avif","attachment_file":"cintra.avif","attachment_path":"https://bucket.farra.media/cintra.avif","attachment_alt":"Gui Cintra"}', 1716342389000, 1721171508384
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-gui-cintra-pt-br');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'Gui Cintra', 'gui-cintra-pt-br', '', 'Sócio, diretor e roteirista', 'published', '{"order":0,"image":"https://bucket.farra.media/cintra.avif","language":"ptbr","videos":"1e56330a-f375-4fbd-bcfc-b9a26bc32589","videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":["https://www.linkedin.com/in/guicintra","https://www.instagram.com/cintra/","https://twitter.com/guicintra"],"reel":null,"posttype":"equipe","legacy_id":"a0ae5b15-339a-477a-befb-4989e2381336","legacy_posttype":"equipe","images":"[\"https://bucket.farra.media/bg-o-que-fazemos11.webp\"]"}', 1716342389000, 1716342389000, 1721171508384
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='gui-cintra-pt-br');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='gui-cintra-pt-br' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-gui-cintra-pt-br' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='gui-cintra-pt-br') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-gui-cintra-pt-br');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='gui-cintra-pt-br' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='gui-cintra-pt-br') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-gui-cintra-pt-br' LIMIT 1)) WHERE slug='gui-cintra-pt-br';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='gui-cintra-pt-br' AND id_locale_code IS NULL;

-- Gui Vieira (c97d60a0-6245-42cf-afc3-eeadccf1165f) locale=en_US
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'gui-vieira-2.avif', 'attachment-equipe-gui-vieira-en-us', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/avif","attachment_file":"gui-vieira-2.avif","attachment_path":"https://bucket.farra.media/gui-vieira-2.avif","attachment_alt":"Gui Vieira"}', 1718910610754, 1718910689762
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-gui-vieira-en-us');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1), 'Gui Vieira', 'gui-vieira-en-us', '', 'Partner and executive producer', 'published', '{"order":0,"image":"https://bucket.farra.media/gui-vieira-2.avif","language":"enUS","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":["https://www.linkedin.com/in/gui-vieira-19635046/"],"reel":null,"posttype":"equipe","legacy_id":"c97d60a0-6245-42cf-afc3-eeadccf1165f","legacy_posttype":"equipe"}', 1718910610754, 1718910610754, 1718910689762
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='gui-vieira-en-us');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='gui-vieira-en-us' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-gui-vieira-en-us' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='gui-vieira-en-us') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-gui-vieira-en-us');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='gui-vieira-en-us' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='gui-vieira-en-us') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-gui-vieira-en-us' LIMIT 1)) WHERE slug='gui-vieira-en-us';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='gui-vieira-en-us' AND id_locale_code IS NULL;

-- Gui Vieira (350ed4bd-b228-4430-8a87-fa620ef401bb) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'gui-vieira-2.avif', 'attachment-equipe-gui-vieira-pt-br', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/avif","attachment_file":"gui-vieira-2.avif","attachment_path":"https://bucket.farra.media/gui-vieira-2.avif","attachment_alt":"Gui Vieira"}', 1716342288848, 1718910551896
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-gui-vieira-pt-br');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'Gui Vieira', 'gui-vieira-pt-br', '', 'Sócio e produtor executivo', 'published', '{"order":0,"image":"https://bucket.farra.media/gui-vieira-2.avif","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":["https://www.linkedin.com/in/gui-vieira-19635046/"],"reel":null,"posttype":"equipe","legacy_id":"350ed4bd-b228-4430-8a87-fa620ef401bb","legacy_posttype":"equipe"}', 1716342288848, 1716342288848, 1718910551896
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='gui-vieira-pt-br');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='gui-vieira-pt-br' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-gui-vieira-pt-br' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='gui-vieira-pt-br') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-gui-vieira-pt-br');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='gui-vieira-pt-br' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='gui-vieira-pt-br') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-gui-vieira-pt-br' LIMIT 1)) WHERE slug='gui-vieira-pt-br';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='gui-vieira-pt-br' AND id_locale_code IS NULL;

-- Jamile Godoy (2b3dbaa3-904f-48e2-8401-043725c10c73) locale=en_US
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'sd.png', 'attachment-equipe-jamile-godoy-en-us', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"sd.png","attachment_path":"https://bucket.farra.media/sd.png","attachment_alt":"Jamile Godoy"}', 1749669023000, 1749669056408
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-jamile-godoy-en-us');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1), 'Jamile Godoy', 'jamile-godoy-en-us', '', 'Writer', 'published', '{"order":0,"image":"https://bucket.farra.media/sd.png","language":"enUS","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"equipe","legacy_id":"2b3dbaa3-904f-48e2-8401-043725c10c73","legacy_posttype":"equipe"}', 1749669023000, 1749669023000, 1749669056408
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='jamile-godoy-en-us');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='jamile-godoy-en-us' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-jamile-godoy-en-us' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='jamile-godoy-en-us') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-jamile-godoy-en-us');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='jamile-godoy-en-us' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='jamile-godoy-en-us') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-jamile-godoy-en-us' LIMIT 1)) WHERE slug='jamile-godoy-en-us';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='jamile-godoy-en-us' AND id_locale_code IS NULL;

-- Jamile Godoy (226e9e1f-1b1c-4e76-9920-7b56c9609c55) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'sd.png', 'attachment-equipe-jamile-godoy-pt-br', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"sd.png","attachment_path":"https://bucket.farra.media/sd.png","attachment_alt":"Jamile Godoy"}', 1749668900505, 1749668900505
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-jamile-godoy-pt-br');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'Jamile Godoy', 'jamile-godoy-pt-br', '', 'Roteirista', 'published', '{"order":0,"image":"https://bucket.farra.media/sd.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"equipe","legacy_id":"226e9e1f-1b1c-4e76-9920-7b56c9609c55","legacy_posttype":"equipe"}', 1749668900505, 1749668900505, 1749668900505
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='jamile-godoy-pt-br');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='jamile-godoy-pt-br' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-jamile-godoy-pt-br' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='jamile-godoy-pt-br') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-jamile-godoy-pt-br');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='jamile-godoy-pt-br' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='jamile-godoy-pt-br') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-jamile-godoy-pt-br' LIMIT 1)) WHERE slug='jamile-godoy-pt-br';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='jamile-godoy-pt-br' AND id_locale_code IS NULL;

-- Juliana Hodas (ec56c757-70ac-4d33-af68-d2f9c0b82156) locale=en_US
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'ju.png', 'attachment-equipe-juliana-hodas-en-us', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"ju.png","attachment_path":"https://bucket.farra.media/ju.png","attachment_alt":"Juliana Hodas"}', 1716342121000, 1749669498817
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-juliana-hodas-en-us');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1), 'Juliana Hodas', 'juliana-hodas-en-us', '', 'Production director', 'published', '{"order":0,"image":"https://bucket.farra.media/ju.png","language":"enUS","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"equipe","legacy_id":"ec56c757-70ac-4d33-af68-d2f9c0b82156","legacy_posttype":"equipe"}', 1716342121000, 1716342121000, 1749669498817
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='juliana-hodas-en-us');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='juliana-hodas-en-us' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-juliana-hodas-en-us' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='juliana-hodas-en-us') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-juliana-hodas-en-us');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='juliana-hodas-en-us' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='juliana-hodas-en-us') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-juliana-hodas-en-us' LIMIT 1)) WHERE slug='juliana-hodas-en-us';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='juliana-hodas-en-us' AND id_locale_code IS NULL;

-- Juliana Hodas (0b3fcf9c-a5cf-49e2-ba2a-55c31de26a7f) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'ju.png', 'attachment-equipe-juliana-hodas-pt-br', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"ju.png","attachment_path":"https://bucket.farra.media/ju.png","attachment_alt":"Juliana Hodas"}', 1716342140000, 1749669429415
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-juliana-hodas-pt-br');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'Juliana Hodas', 'juliana-hodas-pt-br', '', 'Direção de Produção', 'published', '{"order":0,"image":"https://bucket.farra.media/ju.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"equipe","legacy_id":"0b3fcf9c-a5cf-49e2-ba2a-55c31de26a7f","legacy_posttype":"equipe"}', 1716342140000, 1716342140000, 1749669429415
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='juliana-hodas-pt-br');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='juliana-hodas-pt-br' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-juliana-hodas-pt-br' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='juliana-hodas-pt-br') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-juliana-hodas-pt-br');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='juliana-hodas-pt-br' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='juliana-hodas-pt-br') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-juliana-hodas-pt-br' LIMIT 1)) WHERE slug='juliana-hodas-pt-br';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='juliana-hodas-pt-br' AND id_locale_code IS NULL;

-- Lais Paixão (4e415bec-7bb9-409b-9e04-5e96968b1691) locale=en_US
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'm,.png', 'attachment-equipe-lais-paixao-en-us', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"m,.png","attachment_path":"https://bucket.farra.media/m,.png","attachment_alt":"Lais Paix\u00e3o"}', 1749669649000, 1749669679205
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-lais-paixao-en-us');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1), 'Lais Paixão', 'lais-paixao-en-us', '', 'Coordenação de Pós-produção', 'published', '{"order":0,"image":"https://bucket.farra.media/m,.png","language":"enUS","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"equipe","legacy_id":"4e415bec-7bb9-409b-9e04-5e96968b1691","legacy_posttype":"equipe"}', 1749669649000, 1749669649000, 1749669679205
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='lais-paixao-en-us');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='lais-paixao-en-us' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-lais-paixao-en-us' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='lais-paixao-en-us') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-lais-paixao-en-us');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='lais-paixao-en-us' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='lais-paixao-en-us') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-lais-paixao-en-us' LIMIT 1)) WHERE slug='lais-paixao-en-us';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='lais-paixao-en-us' AND id_locale_code IS NULL;

-- Lais Paixão (002a1935-b075-49ad-aba4-85a5aa290da6) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'm,.png', 'attachment-equipe-lais-paixao-pt-br', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"m,.png","attachment_path":"https://bucket.farra.media/m,.png","attachment_alt":"Lais Paix\u00e3o"}', 1716340719000, 1749666694796
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-lais-paixao-pt-br');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'Lais Paixão', 'lais-paixao-pt-br', '', 'Coordenação de Pós-produção', 'published', '{"order":0,"image":"https://bucket.farra.media/m,.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"equipe","legacy_id":"002a1935-b075-49ad-aba4-85a5aa290da6","legacy_posttype":"equipe"}', 1716340719000, 1716340719000, 1749666694796
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='lais-paixao-pt-br');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='lais-paixao-pt-br' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-lais-paixao-pt-br' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='lais-paixao-pt-br') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-lais-paixao-pt-br');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='lais-paixao-pt-br' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='lais-paixao-pt-br') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-lais-paixao-pt-br' LIMIT 1)) WHERE slug='lais-paixao-pt-br';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='lais-paixao-pt-br' AND id_locale_code IS NULL;

-- Mike Prado (aaad9940-f6fe-47f4-8902-d1632bf841c4) locale=en_US
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'bbf3d613-73db-4fe5-9ba7-4c1559310641.jpg', 'attachment-equipe-mike-prado-en-us', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/jpeg","attachment_file":"bbf3d613-73db-4fe5-9ba7-4c1559310641.jpg","attachment_path":"https://bucket.farra.media/bbf3d613-73db-4fe5-9ba7-4c1559310641.jpg","attachment_alt":"Mike Prado"}', 1726607561000, 1726607576297
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-mike-prado-en-us');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1), 'Mike Prado', 'mike-prado-en-us', '', 'Editor', 'published', '{"order":0,"image":"https://bucket.farra.media/bbf3d613-73db-4fe5-9ba7-4c1559310641.jpg","language":"enUS","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"equipe","legacy_id":"aaad9940-f6fe-47f4-8902-d1632bf841c4","legacy_posttype":"equipe"}', 1726607561000, 1726607561000, 1726607576297
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='mike-prado-en-us');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='mike-prado-en-us' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-mike-prado-en-us' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='mike-prado-en-us') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-mike-prado-en-us');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='mike-prado-en-us' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='mike-prado-en-us') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-mike-prado-en-us' LIMIT 1)) WHERE slug='mike-prado-en-us';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='mike-prado-en-us' AND id_locale_code IS NULL;

-- Mike Prado (8c5ae0fc-a684-461b-a202-3d54aeb39441) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'bbf3d613-73db-4fe5-9ba7-4c1559310641.jpg', 'attachment-equipe-mike-prado-pt-br', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/jpeg","attachment_file":"bbf3d613-73db-4fe5-9ba7-4c1559310641.jpg","attachment_path":"https://bucket.farra.media/bbf3d613-73db-4fe5-9ba7-4c1559310641.jpg","attachment_alt":"Mike Prado"}', 1726607473000, 1726607524212
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-mike-prado-pt-br');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'Mike Prado', 'mike-prado-pt-br', '', 'Editor', 'published', '{"order":0,"image":"https://bucket.farra.media/bbf3d613-73db-4fe5-9ba7-4c1559310641.jpg","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"equipe","legacy_id":"8c5ae0fc-a684-461b-a202-3d54aeb39441","legacy_posttype":"equipe"}', 1726607473000, 1726607473000, 1726607524212
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='mike-prado-pt-br');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='mike-prado-pt-br' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-mike-prado-pt-br' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='mike-prado-pt-br') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-mike-prado-pt-br');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='mike-prado-pt-br' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='mike-prado-pt-br') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-mike-prado-pt-br' LIMIT 1)) WHERE slug='mike-prado-pt-br';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='mike-prado-pt-br' AND id_locale_code IS NULL;

-- Patrícia Vergili (184f1719-4155-4335-b2e3-7bdfe2a548ba) locale=en_US
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'aa.png', 'attachment-equipe-patricia-vergili-en-us', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"aa.png","attachment_path":"https://bucket.farra.media/aa.png","attachment_alt":"Patr\u00edcia Vergili"}', 1749669104000, 1749669125603
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-patricia-vergili-en-us');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1), 'Patrícia Vergili', 'patricia-vergili-en-us', '', 'Gestão de Redes Sociais', 'published', '{"order":0,"image":"https://bucket.farra.media/aa.png","language":"enUS","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"equipe","legacy_id":"184f1719-4155-4335-b2e3-7bdfe2a548ba","legacy_posttype":"equipe"}', 1749669104000, 1749669104000, 1749669125603
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='patricia-vergili-en-us');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='patricia-vergili-en-us' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-patricia-vergili-en-us' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='patricia-vergili-en-us') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-patricia-vergili-en-us');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='patricia-vergili-en-us' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='patricia-vergili-en-us') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-patricia-vergili-en-us' LIMIT 1)) WHERE slug='patricia-vergili-en-us';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='patricia-vergili-en-us' AND id_locale_code IS NULL;

-- Patrícia Vergili (4c567db7-cd77-44f8-9ebe-b812d090842a) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'aa.png', 'attachment-equipe-patricia-vergili-pt-br', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"aa.png","attachment_path":"https://bucket.farra.media/aa.png","attachment_alt":"Patr\u00edcia Vergili"}', 1749668854775, 1749668854775
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-patricia-vergili-pt-br');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'Patrícia Vergili', 'patricia-vergili-pt-br', '', 'Gestão de Redes Sociais', 'published', '{"order":0,"image":"https://bucket.farra.media/aa.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"equipe","legacy_id":"4c567db7-cd77-44f8-9ebe-b812d090842a","legacy_posttype":"equipe"}', 1749668854775, 1749668854775, 1749668854775
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='patricia-vergili-pt-br');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='patricia-vergili-pt-br' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-patricia-vergili-pt-br' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='patricia-vergili-pt-br') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-patricia-vergili-pt-br');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='patricia-vergili-pt-br' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='patricia-vergili-pt-br') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-patricia-vergili-pt-br' LIMIT 1)) WHERE slug='patricia-vergili-pt-br';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='patricia-vergili-pt-br' AND id_locale_code IS NULL;

-- Rodrigo Moura (543eeb66-3f5b-4cbb-8a06-f68c9975fa24) locale=en_US
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'rod.png', 'attachment-equipe-rodrigo-moura-en-us', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"rod.png","attachment_path":"https://bucket.farra.media/rod.png","attachment_alt":"Rodrigo Moura"}', 1716341881000, 1749669620429
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-rodrigo-moura-en-us');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1), 'Rodrigo Moura', 'rodrigo-moura-en-us', '', 'Writer', 'published', '{"order":0,"image":"https://bucket.farra.media/rod.png","language":"enUS","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"equipe","legacy_id":"543eeb66-3f5b-4cbb-8a06-f68c9975fa24","legacy_posttype":"equipe"}', 1716341881000, 1716341881000, 1749669620429
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='rodrigo-moura-en-us');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='rodrigo-moura-en-us' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-rodrigo-moura-en-us' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='rodrigo-moura-en-us') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-rodrigo-moura-en-us');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='rodrigo-moura-en-us' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='rodrigo-moura-en-us') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-rodrigo-moura-en-us' LIMIT 1)) WHERE slug='rodrigo-moura-en-us';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='rodrigo-moura-en-us' AND id_locale_code IS NULL;

-- Rodrigo Moura (ff9331e2-a891-4d43-8147-f832eecc3b14) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'rod.png', 'attachment-equipe-rodrigo-moura-pt-br', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"rod.png","attachment_path":"https://bucket.farra.media/rod.png","attachment_alt":"Rodrigo Moura"}', 1716341905000, 1749669564792
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-rodrigo-moura-pt-br');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'Rodrigo Moura', 'rodrigo-moura-pt-br', '', 'Roteiro', 'published', '{"order":0,"image":"https://bucket.farra.media/rod.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"equipe","legacy_id":"ff9331e2-a891-4d43-8147-f832eecc3b14","legacy_posttype":"equipe"}', 1716341905000, 1716341905000, 1749669564792
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='rodrigo-moura-pt-br');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='rodrigo-moura-pt-br' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-rodrigo-moura-pt-br' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='rodrigo-moura-pt-br') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-rodrigo-moura-pt-br');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='rodrigo-moura-pt-br' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='rodrigo-moura-pt-br') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-rodrigo-moura-pt-br' LIMIT 1)) WHERE slug='rodrigo-moura-pt-br';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='rodrigo-moura-pt-br' AND id_locale_code IS NULL;

-- Vic Rodriguez (ac01b910-3281-4c1f-be98-7220ca4ce6e0) locale=en_US
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'Captura de Tela 2025-06-11 às 15.11.53.png', 'attachment-equipe-vic-rodriguez-en-us', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"Captura de Tela 2025-06-11 \u00e0s 15.11.53.png","attachment_path":"https://bucket.farra.media/Captura de Tela 2025-06-11 \u00e0s 15.11.53.png","attachment_alt":"Vic Rodriguez"}', 1716342039000, 1749670898221
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-vic-rodriguez-en-us');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1), 'Vic Rodriguez', 'vic-rodriguez-en-us', '', 'Executive producer assistant', 'published', '{"order":0,"image":"https://bucket.farra.media/Captura de Tela 2025-06-11 \u00e0s 15.11.53.png","language":"enUS","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"equipe","legacy_id":"ac01b910-3281-4c1f-be98-7220ca4ce6e0","legacy_posttype":"equipe"}', 1716342039000, 1716342039000, 1749670898221
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='vic-rodriguez-en-us');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='vic-rodriguez-en-us' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-vic-rodriguez-en-us' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='vic-rodriguez-en-us') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-vic-rodriguez-en-us');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='vic-rodriguez-en-us' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='vic-rodriguez-en-us') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-vic-rodriguez-en-us' LIMIT 1)) WHERE slug='vic-rodriguez-en-us';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='vic-rodriguez-en-us' AND id_locale_code IS NULL;

-- Vic Rodriguez (e56963aa-c25d-41e8-9ba8-b8623553edef) locale=pt_BR
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'Captura de Tela 2025-06-11 às 15.11.53.png', 'attachment-equipe-vic-rodriguez-pt-br', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"Captura de Tela 2025-06-11 \u00e0s 15.11.53.png","attachment_path":"https://bucket.farra.media/Captura de Tela 2025-06-11 \u00e0s 15.11.53.png","attachment_alt":"Vic Rodriguez"}', 1726602816000, 1749670826696
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-vic-rodriguez-pt-br');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'Vic Rodriguez', 'vic-rodriguez-pt-br', '', 'Assistente de Produção Executiva', 'published', '{"order":0,"image":"https://bucket.farra.media/Captura de Tela 2025-06-11 \u00e0s 15.11.53.png","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"equipe","legacy_id":"e56963aa-c25d-41e8-9ba8-b8623553edef","legacy_posttype":"equipe"}', 1726602816000, 1726602816000, 1749670826696
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='vic-rodriguez-pt-br');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='vic-rodriguez-pt-br' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-equipe-vic-rodriguez-pt-br' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='vic-rodriguez-pt-br') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-equipe-vic-rodriguez-pt-br');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='vic-rodriguez-pt-br' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='vic-rodriguez-pt-br') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='equipe' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-equipe-vic-rodriguez-pt-br' LIMIT 1)) WHERE slug='vic-rodriguez-pt-br';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='vic-rodriguez-pt-br' AND id_locale_code IS NULL;

-- Garante categoria equipe nos posts migrados
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT p.id, (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
FROM edp_posts p
INNER JOIN edp_post_types pt ON pt.id = p.post_type_id AND pt.slug = 'post'
WHERE json_extract(p.meta_values, '$.legacy_posttype') = 'equipe'
  AND NOT EXISTS (
    SELECT 1 FROM edp_posts_taxonomies px WHERE px.post_id = p.id
      AND px.term_id = (SELECT id FROM edp_taxonomies WHERE slug='equipe' AND type='category' LIMIT 1)
  );

UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1)
WHERE post_type_id = (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1)
  AND json_extract(meta_values, '$.legacy_posttype') = 'equipe'
  AND json_extract(meta_values, '$.language') = 'ptbr'
  AND id_locale_code IS NULL;

UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1)
WHERE post_type_id = (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1)
  AND json_extract(meta_values, '$.legacy_posttype') = 'equipe'
  AND json_extract(meta_values, '$.language') = 'enUS'
  AND id_locale_code IS NULL;

-- Sócios (grid A Farra): meta dono=sim + ordem de exibição
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.dono', 'sim', '$.order', 1)
WHERE slug IN ('gui-cintra-pt-br', 'gui-cintra-en-us');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.dono', 'sim', '$.order', 2)
WHERE slug IN ('andre-brandt-pt-br', 'andre-brandt-en-us');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.dono', 'sim', '$.order', 3)
WHERE slug IN ('gui-vieira-pt-br', 'gui-vieira-en-us');
