-- Migração O que fazemos (SonicJS -> EdgePress)
-- Intro legado posttype=oquefazemos -> post type page (2 páginas PT/EN)
-- Itens legado tipooquefazemos -> post type post + categoria o-que-fazemos (8 itens)
-- Pré-requisito: seed (post, page, attachment, taxonomies categoria, locales pt_BR/en_US)
-- meta posttype "oquefazemos" / "tipooquefazemos" mantidos para compatibilidade farramedia

-- Categoria "o-que-fazemos" filha de "categoria"
INSERT OR IGNORE INTO taxonomies (name, slug, type, parent_id, created_at, updated_at)
SELECT 'O que fazemos', 'o-que-fazemos', 'category', (SELECT id FROM taxonomies WHERE slug='categoria' LIMIT 1), 0, 0
WHERE NOT EXISTS (SELECT 1 FROM taxonomies WHERE slug='o-que-fazemos' AND type='category');

-- ENTRETENIMENTO PARA TODAS AS MÍDIAS — página intro PT (03cbbd78-c710-4a7e-b5ba-9be32740f423)
INSERT OR IGNORE INTO posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='attachment' LIMIT 1), 'banner_o-que-fazemos_-desktop_ptbr.avif', 'attachment-oquefazemos-pt-desktop', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/avif","attachment_file":"banner_o-que-fazemos_-desktop_ptbr.avif","attachment_path":"https://bucket.farra.media/banner_o-que-fazemos_-desktop_ptbr.avif","attachment_alt":"ENTRETENIMENTO PARA TODAS AS MÍDIAS"}', 1717970785000, 1727359584757
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='attachment-oquefazemos-pt-desktop');
INSERT OR IGNORE INTO posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='attachment' LIMIT 1), 'banner_site_o-que-fazemos_mobile_ptbr_v2.avif', 'attachment-oquefazemos-pt-mobile', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/avif","attachment_file":"banner_site_o-que-fazemos_mobile_ptbr_v2.avif","attachment_path":"https://bucket.farra.media/banner_site_o-que-fazemos_mobile_ptbr_v2.avif","attachment_alt":"ENTRETENIMENTO PARA TODAS AS MÍDIAS"}', 1717970785000, 1727359584757
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='attachment-oquefazemos-pt-mobile');
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='page' LIMIT 1), (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1), 'ENTRETENIMENTO PARA TODAS AS MÍDIAS', 'entretenimento-para-todas-as-midias', '', '', 'published', '{"order":0,"image":"https://bucket.farra.media/banner_o-que-fazemos_-desktop_ptbr.avif","images":"[\"https://bucket.farra.media/banner_site_o-que-fazemos_mobile_ptbr_v2.avif\"]","language":"ptbr","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"oquefazemos","legacy_id":"03cbbd78-c710-4a7e-b5ba-9be32740f423","legacy_posttype":"oquefazemos"}', 1717970785000, 1717970785000, 1727359584757
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='entretenimento-para-todas-as-midias');
INSERT OR IGNORE INTO posts_media (post_id, media_id)
SELECT (SELECT id FROM posts WHERE slug='entretenimento-para-todas-as-midias' LIMIT 1), (SELECT id FROM posts WHERE slug='attachment-oquefazemos-pt-desktop' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='entretenimento-para-todas-as-midias') AND EXISTS (SELECT 1 FROM posts WHERE slug='attachment-oquefazemos-pt-desktop');
INSERT OR IGNORE INTO posts_media (post_id, media_id)
SELECT (SELECT id FROM posts WHERE slug='entretenimento-para-todas-as-midias' LIMIT 1), (SELECT id FROM posts WHERE slug='attachment-oquefazemos-pt-mobile' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='entretenimento-para-todas-as-midias') AND EXISTS (SELECT 1 FROM posts WHERE slug='attachment-oquefazemos-pt-mobile');
UPDATE posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM posts WHERE slug='attachment-oquefazemos-pt-desktop' LIMIT 1)) WHERE slug='entretenimento-para-todas-as-midias';
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='entretenimento-para-todas-as-midias' AND id_locale_code IS NULL;

-- ENTERTAINMENT FOR ALL MEDIA — página intro EN (65d03fa6-257b-4516-be78-5727bf17b81d)
INSERT OR IGNORE INTO posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='attachment' LIMIT 1), 'banner_o-que-fazemos_-desktop_en.avif', 'attachment-oquefazemos-en-desktop', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/avif","attachment_file":"banner_o-que-fazemos_-desktop_en.avif","attachment_path":"https://bucket.farra.media/banner_o-que-fazemos_-desktop_en.avif","attachment_alt":"ENTERTAINMENT FOR ALL MEDIA"}', 1717970856000, 1727359613330
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='attachment-oquefazemos-en-desktop');
INSERT OR IGNORE INTO posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='attachment' LIMIT 1), 'banner_site_o-que-fazemos_mobile_en_v2.avif', 'attachment-oquefazemos-en-mobile', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/avif","attachment_file":"banner_site_o-que-fazemos_mobile_en_v2.avif","attachment_path":"https://bucket.farra.media/banner_site_o-que-fazemos_mobile_en_v2.avif","attachment_alt":"ENTERTAINMENT FOR ALL MEDIA"}', 1717970856000, 1727359613330
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='attachment-oquefazemos-en-mobile');
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='page' LIMIT 1), (SELECT id FROM locales WHERE locale_code='en_US' LIMIT 1), 'ENTERTAINMENT FOR ALL MEDIA', 'entertainment-for-all-media', '', '', 'published', '{"order":0,"image":"https://bucket.farra.media/banner_o-que-fazemos_-desktop_en.avif","images":"[\"https://bucket.farra.media/banner_site_o-que-fazemos_mobile_en_v2.avif\"]","language":"enUS","videos":null,"videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":null,"reel":null,"posttype":"oquefazemos","legacy_id":"65d03fa6-257b-4516-be78-5727bf17b81d","legacy_posttype":"oquefazemos"}', 1717970856000, 1717970856000, 1727359613330
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='entertainment-for-all-media');
INSERT OR IGNORE INTO posts_media (post_id, media_id)
SELECT (SELECT id FROM posts WHERE slug='entertainment-for-all-media' LIMIT 1), (SELECT id FROM posts WHERE slug='attachment-oquefazemos-en-desktop' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='entertainment-for-all-media') AND EXISTS (SELECT 1 FROM posts WHERE slug='attachment-oquefazemos-en-desktop');
INSERT OR IGNORE INTO posts_media (post_id, media_id)
SELECT (SELECT id FROM posts WHERE slug='entertainment-for-all-media' LIMIT 1), (SELECT id FROM posts WHERE slug='attachment-oquefazemos-en-mobile' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='entertainment-for-all-media') AND EXISTS (SELECT 1 FROM posts WHERE slug='attachment-oquefazemos-en-mobile');
UPDATE posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM posts WHERE slug='attachment-oquefazemos-en-desktop' LIMIT 1)) WHERE slug='entertainment-for-all-media';
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='entertainment-for-all-media' AND id_locale_code IS NULL;

-- BRANDED ENTERTAINMENT (23aae32f-e956-40ca-9f59-2f78d42e3f1e) locale=pt_BR
INSERT OR IGNORE INTO posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='attachment' LIMIT 1), 'publicidade.png', 'attachment-o-que-fazemos-branded-entertainment', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"publicidade.png","attachment_path":"https://bucket.farra.media/publicidade.png","attachment_alt":"BRANDED ENTERTAINMENT"}', 1717972719455, 1717972988283
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='attachment-o-que-fazemos-branded-entertainment');
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='post' LIMIT 1), (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1), 'BRANDED ENTERTAINMENT', 'branded-entertainment', 'published', '{"order":0,"image":"https://bucket.farra.media/publicidade.png","language":"ptbr","videos":null,"fichaTecnica":[],"socialMedia":null,"posttype":"tipooquefazemos","legacy_id":"23aae32f-e956-40ca-9f59-2f78d42e3f1e","legacy_posttype":"tipooquefazemos"}', 1717972719455, 1717972719455, 1717972988283
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='branded-entertainment');
INSERT OR IGNORE INTO posts_media (post_id, media_id)
SELECT (SELECT id FROM posts WHERE slug='branded-entertainment' LIMIT 1), (SELECT id FROM posts WHERE slug='attachment-o-que-fazemos-branded-entertainment' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='branded-entertainment') AND EXISTS (SELECT 1 FROM posts WHERE slug='attachment-o-que-fazemos-branded-entertainment');
INSERT OR IGNORE INTO posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM posts WHERE slug='branded-entertainment' LIMIT 1), (SELECT id FROM taxonomies WHERE slug='o-que-fazemos' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='branded-entertainment') AND EXISTS (SELECT 1 FROM taxonomies WHERE slug='o-que-fazemos' AND type='category');
UPDATE posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM posts WHERE slug='attachment-o-que-fazemos-branded-entertainment' LIMIT 1)) WHERE slug='branded-entertainment';
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='branded-entertainment' AND id_locale_code IS NULL;

-- Cinema (b11ea83b-4f54-4a18-8b68-ead202f4d52a) locale=pt_BR
INSERT OR IGNORE INTO posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='attachment' LIMIT 1), 'cinema.png', 'attachment-o-que-fazemos-cinema', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"cinema.png","attachment_path":"https://bucket.farra.media/cinema.png","attachment_alt":"Cinema"}', 1717972629005, 1717973003377
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='attachment-o-que-fazemos-cinema');
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='post' LIMIT 1), (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1), 'Cinema', 'cinema', 'published', '{"order":0,"image":"https://bucket.farra.media/cinema.png","language":"ptbr","videos":null,"fichaTecnica":[],"socialMedia":null,"posttype":"tipooquefazemos","legacy_id":"b11ea83b-4f54-4a18-8b68-ead202f4d52a","legacy_posttype":"tipooquefazemos"}', 1717972629005, 1717972629005, 1717973003377
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='cinema');
INSERT OR IGNORE INTO posts_media (post_id, media_id)
SELECT (SELECT id FROM posts WHERE slug='cinema' LIMIT 1), (SELECT id FROM posts WHERE slug='attachment-o-que-fazemos-cinema' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='cinema') AND EXISTS (SELECT 1 FROM posts WHERE slug='attachment-o-que-fazemos-cinema');
INSERT OR IGNORE INTO posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM posts WHERE slug='cinema' LIMIT 1), (SELECT id FROM taxonomies WHERE slug='o-que-fazemos' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='cinema') AND EXISTS (SELECT 1 FROM taxonomies WHERE slug='o-que-fazemos' AND type='category');
UPDATE posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM posts WHERE slug='attachment-o-que-fazemos-cinema' LIMIT 1)) WHERE slug='cinema';
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='cinema' AND id_locale_code IS NULL;

-- Corporativo (b37edcf8-6ac1-4bde-b006-f5d909ddff3e) locale=pt_BR
INSERT OR IGNORE INTO posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='attachment' LIMIT 1), 'corporativo.png', 'attachment-o-que-fazemos-corporativo', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"corporativo.png","attachment_path":"https://bucket.farra.media/corporativo.png","attachment_alt":"Corporativo"}', 1717972580517, 1717973017995
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='attachment-o-que-fazemos-corporativo');
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='post' LIMIT 1), (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1), 'Corporativo', 'corporativo', 'published', '{"order":0,"image":"https://bucket.farra.media/corporativo.png","language":"ptbr","videos":null,"fichaTecnica":[],"socialMedia":null,"posttype":"tipooquefazemos","legacy_id":"b37edcf8-6ac1-4bde-b006-f5d909ddff3e","legacy_posttype":"tipooquefazemos"}', 1717972580517, 1717972580517, 1717973017995
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='corporativo');
INSERT OR IGNORE INTO posts_media (post_id, media_id)
SELECT (SELECT id FROM posts WHERE slug='corporativo' LIMIT 1), (SELECT id FROM posts WHERE slug='attachment-o-que-fazemos-corporativo' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='corporativo') AND EXISTS (SELECT 1 FROM posts WHERE slug='attachment-o-que-fazemos-corporativo');
INSERT OR IGNORE INTO posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM posts WHERE slug='corporativo' LIMIT 1), (SELECT id FROM taxonomies WHERE slug='o-que-fazemos' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='corporativo') AND EXISTS (SELECT 1 FROM taxonomies WHERE slug='o-que-fazemos' AND type='category');
UPDATE posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM posts WHERE slug='attachment-o-que-fazemos-corporativo' LIMIT 1)) WHERE slug='corporativo';
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='corporativo' AND id_locale_code IS NULL;

-- Lives e Eventos (7de458ad-b64f-4ce5-a6dc-5b314827d264) locale=pt_BR
INSERT OR IGNORE INTO posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='attachment' LIMIT 1), 'instagram-ao-vivo.png', 'attachment-o-que-fazemos-lives-e-eventos', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"instagram-ao-vivo.png","attachment_path":"https://bucket.farra.media/instagram-ao-vivo.png","attachment_alt":"Lives e Eventos"}', 1717972598981, 1717973013378
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='attachment-o-que-fazemos-lives-e-eventos');
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='post' LIMIT 1), (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1), 'Lives e Eventos', 'lives-e-eventos', 'published', '{"order":0,"image":"https://bucket.farra.media/instagram-ao-vivo.png","language":"ptbr","videos":null,"fichaTecnica":[],"socialMedia":null,"posttype":"tipooquefazemos","legacy_id":"7de458ad-b64f-4ce5-a6dc-5b314827d264","legacy_posttype":"tipooquefazemos"}', 1717972598981, 1717972598981, 1717973013378
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='lives-e-eventos');
INSERT OR IGNORE INTO posts_media (post_id, media_id)
SELECT (SELECT id FROM posts WHERE slug='lives-e-eventos' LIMIT 1), (SELECT id FROM posts WHERE slug='attachment-o-que-fazemos-lives-e-eventos' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='lives-e-eventos') AND EXISTS (SELECT 1 FROM posts WHERE slug='attachment-o-que-fazemos-lives-e-eventos');
INSERT OR IGNORE INTO posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM posts WHERE slug='lives-e-eventos' LIMIT 1), (SELECT id FROM taxonomies WHERE slug='o-que-fazemos' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='lives-e-eventos') AND EXISTS (SELECT 1 FROM taxonomies WHERE slug='o-que-fazemos' AND type='category');
UPDATE posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM posts WHERE slug='attachment-o-que-fazemos-lives-e-eventos' LIMIT 1)) WHERE slug='lives-e-eventos';
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='lives-e-eventos' AND id_locale_code IS NULL;

-- Podcasts (82a153e2-00a7-45d4-a1d2-2e56b6273e1b) locale=pt_BR
INSERT OR IGNORE INTO posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='attachment' LIMIT 1), 'podcast.png', 'attachment-o-que-fazemos-podcasts', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"podcast.png","attachment_path":"https://bucket.farra.media/podcast.png","attachment_alt":"Podcasts"}', 1717972695785, 1717972998385
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='attachment-o-que-fazemos-podcasts');
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='post' LIMIT 1), (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1), 'Podcasts', 'podcasts', 'published', '{"order":0,"image":"https://bucket.farra.media/podcast.png","language":"ptbr","videos":null,"fichaTecnica":[],"socialMedia":null,"posttype":"tipooquefazemos","legacy_id":"82a153e2-00a7-45d4-a1d2-2e56b6273e1b","legacy_posttype":"tipooquefazemos"}', 1717972695785, 1717972695785, 1717972998385
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='podcasts');
INSERT OR IGNORE INTO posts_media (post_id, media_id)
SELECT (SELECT id FROM posts WHERE slug='podcasts' LIMIT 1), (SELECT id FROM posts WHERE slug='attachment-o-que-fazemos-podcasts' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='podcasts') AND EXISTS (SELECT 1 FROM posts WHERE slug='attachment-o-que-fazemos-podcasts');
INSERT OR IGNORE INTO posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM posts WHERE slug='podcasts' LIMIT 1), (SELECT id FROM taxonomies WHERE slug='o-que-fazemos' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='podcasts') AND EXISTS (SELECT 1 FROM taxonomies WHERE slug='o-que-fazemos' AND type='category');
UPDATE posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM posts WHERE slug='attachment-o-que-fazemos-podcasts' LIMIT 1)) WHERE slug='podcasts';
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='podcasts' AND id_locale_code IS NULL;

-- Publicidade (07c3f26a-a881-4412-b01a-9bd1d4f1666a) locale=pt_BR
INSERT OR IGNORE INTO posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='attachment' LIMIT 1), 'publicidade.png', 'attachment-o-que-fazemos-publicidade', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"publicidade.png","attachment_path":"https://bucket.farra.media/publicidade.png","attachment_alt":"Publicidade"}', 1717972704661, 1717972992978
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='attachment-o-que-fazemos-publicidade');
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='post' LIMIT 1), (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1), 'Publicidade', 'publicidade', 'published', '{"order":0,"image":"https://bucket.farra.media/publicidade.png","language":"ptbr","videos":null,"fichaTecnica":[],"socialMedia":null,"posttype":"tipooquefazemos","legacy_id":"07c3f26a-a881-4412-b01a-9bd1d4f1666a","legacy_posttype":"tipooquefazemos"}', 1717972704661, 1717972704661, 1717972992978
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='publicidade');
INSERT OR IGNORE INTO posts_media (post_id, media_id)
SELECT (SELECT id FROM posts WHERE slug='publicidade' LIMIT 1), (SELECT id FROM posts WHERE slug='attachment-o-que-fazemos-publicidade' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='publicidade') AND EXISTS (SELECT 1 FROM posts WHERE slug='attachment-o-que-fazemos-publicidade');
INSERT OR IGNORE INTO posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM posts WHERE slug='publicidade' LIMIT 1), (SELECT id FROM taxonomies WHERE slug='o-que-fazemos' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='publicidade') AND EXISTS (SELECT 1 FROM taxonomies WHERE slug='o-que-fazemos' AND type='category');
UPDATE posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM posts WHERE slug='attachment-o-que-fazemos-publicidade' LIMIT 1)) WHERE slug='publicidade';
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='publicidade' AND id_locale_code IS NULL;

-- Redes Sociais (8a9c7084-35dc-4862-9add-9dbc332f3982) locale=pt_BR
INSERT OR IGNORE INTO posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='attachment' LIMIT 1), 'midia-social.png', 'attachment-o-que-fazemos-redes-sociais', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"midia-social.png","attachment_path":"https://bucket.farra.media/midia-social.png","attachment_alt":"Redes Sociais"}', 1717972621080, 1717973008242
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='attachment-o-que-fazemos-redes-sociais');
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='post' LIMIT 1), (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1), 'Redes Sociais', 'redes-sociais', 'published', '{"order":0,"image":"https://bucket.farra.media/midia-social.png","language":"ptbr","videos":null,"fichaTecnica":[],"socialMedia":null,"posttype":"tipooquefazemos","legacy_id":"8a9c7084-35dc-4862-9add-9dbc332f3982","legacy_posttype":"tipooquefazemos"}', 1717972621080, 1717972621080, 1717973008242
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='redes-sociais');
INSERT OR IGNORE INTO posts_media (post_id, media_id)
SELECT (SELECT id FROM posts WHERE slug='redes-sociais' LIMIT 1), (SELECT id FROM posts WHERE slug='attachment-o-que-fazemos-redes-sociais' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='redes-sociais') AND EXISTS (SELECT 1 FROM posts WHERE slug='attachment-o-que-fazemos-redes-sociais');
INSERT OR IGNORE INTO posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM posts WHERE slug='redes-sociais' LIMIT 1), (SELECT id FROM taxonomies WHERE slug='o-que-fazemos' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='redes-sociais') AND EXISTS (SELECT 1 FROM taxonomies WHERE slug='o-que-fazemos' AND type='category');
UPDATE posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM posts WHERE slug='attachment-o-que-fazemos-redes-sociais' LIMIT 1)) WHERE slug='redes-sociais';
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='redes-sociais' AND id_locale_code IS NULL;

-- TELEVISÃO E STREAMING (d386e342-5463-4d23-ae65-9d6461b2ad2a) locale=pt_BR
INSERT OR IGNORE INTO posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='attachment' LIMIT 1), 'televisao.png', 'attachment-o-que-fazemos-televisao-e-streaming', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"televisao.png","attachment_path":"https://bucket.farra.media/televisao.png","attachment_alt":"TELEVIS\u00c3O E STREAMING"}', 1717972731313, 1717972983280
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='attachment-o-que-fazemos-televisao-e-streaming');
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='post' LIMIT 1), (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1), 'TELEVISÃO E STREAMING', 'televisao-e-streaming', 'published', '{"order":0,"image":"https://bucket.farra.media/televisao.png","language":"ptbr","videos":null,"fichaTecnica":[],"socialMedia":null,"posttype":"tipooquefazemos","legacy_id":"d386e342-5463-4d23-ae65-9d6461b2ad2a","legacy_posttype":"tipooquefazemos"}', 1717972731313, 1717972731313, 1717972983280
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='televisao-e-streaming');
INSERT OR IGNORE INTO posts_media (post_id, media_id)
SELECT (SELECT id FROM posts WHERE slug='televisao-e-streaming' LIMIT 1), (SELECT id FROM posts WHERE slug='attachment-o-que-fazemos-televisao-e-streaming' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='televisao-e-streaming') AND EXISTS (SELECT 1 FROM posts WHERE slug='attachment-o-que-fazemos-televisao-e-streaming');
INSERT OR IGNORE INTO posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM posts WHERE slug='televisao-e-streaming' LIMIT 1), (SELECT id FROM taxonomies WHERE slug='o-que-fazemos' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='televisao-e-streaming') AND EXISTS (SELECT 1 FROM taxonomies WHERE slug='o-que-fazemos' AND type='category');
UPDATE posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM posts WHERE slug='attachment-o-que-fazemos-televisao-e-streaming' LIMIT 1)) WHERE slug='televisao-e-streaming';
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='televisao-e-streaming' AND id_locale_code IS NULL;

-- Garante categoria o-que-fazemos nos posts migrados
INSERT OR IGNORE INTO posts_taxonomies (post_id, term_id)
SELECT p.id, (SELECT id FROM taxonomies WHERE slug='o-que-fazemos' AND type='category' LIMIT 1)
FROM posts p
INNER JOIN post_types pt ON pt.id = p.post_type_id AND pt.slug = 'post'
WHERE json_extract(p.meta_values, '$.legacy_posttype') = 'tipooquefazemos'
  AND NOT EXISTS (
    SELECT 1 FROM posts_taxonomies px WHERE px.post_id = p.id
      AND px.term_id = (SELECT id FROM taxonomies WHERE slug='o-que-fazemos' AND type='category' LIMIT 1)
  );

UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1)
WHERE post_type_id = (SELECT id FROM post_types WHERE slug='post' LIMIT 1)
  AND json_extract(meta_values, '$.legacy_posttype') = 'tipooquefazemos'
  AND id_locale_code IS NULL;

UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1)
WHERE post_type_id = (SELECT id FROM post_types WHERE slug='page' LIMIT 1)
  AND json_extract(meta_values, '$.legacy_posttype') = 'oquefazemos'
  AND json_extract(meta_values, '$.language') = 'ptbr'
  AND id_locale_code IS NULL;

UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='en_US' LIMIT 1)
WHERE post_type_id = (SELECT id FROM post_types WHERE slug='page' LIMIT 1)
  AND json_extract(meta_values, '$.legacy_posttype') = 'oquefazemos'
  AND json_extract(meta_values, '$.language') = 'enUS'
  AND id_locale_code IS NULL;