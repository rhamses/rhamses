-- Migração Diretores (SonicJS -> EdgePress)
-- Post type: post + categoria "diretores" (type=category)
-- 4 registros PT/EN (Gui Cintra, Hugo Moura). Pré-requisito: seed (post, attachment, taxonomies categoria, locales pt_BR/en_US)
-- meta posttype "diretores" + slug canônico legado em meta_values (ThemeContentGateway sobrescreve slug na API)
-- Custom fields editáveis no admin: migrate-diretores-custom-fields.sql

-- Categoria "diretores" filha de "categoria"
INSERT OR IGNORE INTO edp_taxonomies (name, slug, type, parent_id, created_at, updated_at)
SELECT 'Diretores', 'diretores', 'category', (SELECT id FROM edp_taxonomies WHERE slug='categoria' LIMIT 1), 0, 0
WHERE NOT EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='diretores' AND type='category');

-- Gui Cintra (741de2fb-f561-41ee-b7fb-3a71cde75cdf) locale=en_US canonical=gui-cintra
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'jpeg-optimizer_sk_farra_final_025.jpg', 'attachment-diretores-gui-cintra-en-us', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/jpeg","attachment_file":"jpeg-optimizer_sk_farra_final_025.jpg","attachment_path":"https://bucket.farra.media/jpeg-optimizer_sk_farra_final_025.jpg","attachment_alt":"Gui Cintra"}', 1722380281000, 1727188554396
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-diretores-gui-cintra-en-us');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1), 'Gui Cintra', 'gui-cintra-en-us', '', 'Born in Franca, in the interior of São Paulo, Gui Cintra is a director and screenwriter. A graduate of the University of São Paulo (ECA-USP) and the International Academy of Cinema (AIC), he has directed, developed and created formats for reality shows, documentaries, series and feature films, special branded content projects and advertising films for various market players – such as Netflix, HBO, Disney+, Paramount and Star Originals Productions –, and several brands – such as Nestlé, TIM, TikTok, C&A and Natura. With extensive experience in comedy, he has also directed and written projects starring several talents in Brazilian entertainment, such as Jô Soares, Fábio Porchat, Cláudia Raia, Marcos Mion, Leandro Hassum, Otaviano Costa, Bianca Andrade, Dani Calabresa, Fernanda Souza and Adriane Galisteu.', 'published', '{"order":0,"image":"https://bucket.farra.media/jpeg-optimizer_sk_farra_final_025.jpg","language":"enUS","slug":"gui-cintra","videos":"a036615b-d9e4-431a-ad29-97caa275dedd","videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":["https://vimeo.com/showcase/10469584?share=copy","https://www.imdb.com/name/nm9375650/?language=pt-br","https://www.instagram.com/cintra/","https://www.linkedin.com/in/guicintra"],"reel":"a036615b-d9e4-431a-ad29-97caa275dedd","posttype":"diretores","legacy_id":"741de2fb-f561-41ee-b7fb-3a71cde75cdf","legacy_posttype":"diretores"}', 1722380281000, 1722380281000, 1727188554396
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='gui-cintra-en-us');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='gui-cintra-en-us' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-diretores-gui-cintra-en-us' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='gui-cintra-en-us') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-diretores-gui-cintra-en-us');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='gui-cintra-en-us' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='diretores' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='gui-cintra-en-us') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='diretores' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-diretores-gui-cintra-en-us' LIMIT 1)) WHERE slug='gui-cintra-en-us';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='gui-cintra-en-us' AND id_locale_code IS NULL;

-- Gui Cintra (7e8503fb-1427-4878-bc01-d6a74f560b4d) locale=pt_BR canonical=gui-cintra
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'jpeg-optimizer_sk_farra_final_025.jpg', 'attachment-diretores-gui-cintra-pt-br', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/jpeg","attachment_file":"jpeg-optimizer_sk_farra_final_025.jpg","attachment_path":"https://bucket.farra.media/jpeg-optimizer_sk_farra_final_025.jpg","attachment_alt":"Gui Cintra"}', 1721090014000, 1727188375546
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-diretores-gui-cintra-pt-br');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'Gui Cintra', 'gui-cintra-pt-br', '', 'Nascido em Franca, interior de São Paulo, Gui Cintra é diretor e roteirista. Formado pela Universidade de São Paulo (ECA-USP) e pela Academia Internacional de Cinema (AIC), já dirigiu, desenvolveu e criou formatos de reality shows, documentários, séries e longas de ficção, projetos especiais de branded content e filmes publicitários para diversos players do mercado – como Netflix, HBO, Disney+, Paramount e Star Originals Productions –, e diversas marcas – como Nestlé, TIM, TikTok, C&A e Natura. Com ampla experiência em comédia, também já dirigiu e escreveu projetos protagonizados por diversos talentos do entretenimento brasileiro, como Jô Soares, Fábio Porchat, Cláudia Raia, Marcos Mion, Leandro Hassum, Otaviano Costa, Bianca Andrade, Dani Calabresa, Fernanda Souza e Adriane Galisteu.', 'published', '{"order":0,"image":"https://bucket.farra.media/jpeg-optimizer_sk_farra_final_025.jpg","language":"ptbr","slug":"gui-cintra","videos":"a036615b-d9e4-431a-ad29-97caa275dedd","videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":["https://vimeo.com/showcase/10469584?share=copy","https://www.imdb.com/","https://www.instagram.com/cintra/","https://www.linkedin.com/in/guicintra"],"reel":"a036615b-d9e4-431a-ad29-97caa275dedd","posttype":"diretores","legacy_id":"7e8503fb-1427-4878-bc01-d6a74f560b4d","legacy_posttype":"diretores"}', 1721090014000, 1721090014000, 1727188375546
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='gui-cintra-pt-br');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='gui-cintra-pt-br' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-diretores-gui-cintra-pt-br' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='gui-cintra-pt-br') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-diretores-gui-cintra-pt-br');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='gui-cintra-pt-br' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='diretores' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='gui-cintra-pt-br') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='diretores' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-diretores-gui-cintra-pt-br' LIMIT 1)) WHERE slug='gui-cintra-pt-br';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='gui-cintra-pt-br' AND id_locale_code IS NULL;

-- Hugo Moura (0d85a34d-d056-454f-a657-a9707b7d4213) locale=en_US canonical=hugo-moura
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'jpeg-optimizer_sk_farra_final_029.jpg', 'attachment-diretores-hugo-moura-en-us', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/jpeg","attachment_file":"jpeg-optimizer_sk_farra_final_029.jpg","attachment_path":"https://bucket.farra.media/jpeg-optimizer_sk_farra_final_029.jpg","attachment_alt":"Hugo Moura"}', 1722380215000, 1727188595248
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-diretores-hugo-moura-en-us');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1), 'Hugo Moura', 'hugo-moura-en-us', '', 'Born in Salvador, Bahia, Hugo Moura is a director, publicist, photographer, and actor. He has lived in Rio de Janeiro for 10 years, where he graduated from the Academia Internacional de Cinema (AIC). With over 800 commercials under his belt, he has created campaigns for major brands such as Coca-Cola, Nivea, Loreal, Uber, among others. Hugo specializes in advertising and fashion films, with a keen eye for photography and aesthetic appeal. He has experience filming with major media personalities, and is a well-rounded director in casting, due to his acting experience, and in his photography skills.', 'published', '{"order":0,"image":"https://bucket.farra.media/jpeg-optimizer_sk_farra_final_029.jpg","language":"enUS","slug":"hugo-moura","videos":"3bafc853-df4f-4193-97e9-c59cc95cdb41","videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":["https://vimeo.com/dirhugomoura","https://www.imdb.com/name/nm8122831","https://www.instagram.com/hugomourag"],"reel":"3bafc853-df4f-4193-97e9-c59cc95cdb41","posttype":"diretores","legacy_id":"0d85a34d-d056-454f-a657-a9707b7d4213","legacy_posttype":"diretores","images":"[\"https://bucket.farra.media/hugo-moura.png\"]"}', 1722380215000, 1722380215000, 1727188595248
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='hugo-moura-en-us');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='hugo-moura-en-us' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-diretores-hugo-moura-en-us' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='hugo-moura-en-us') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-diretores-hugo-moura-en-us');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='hugo-moura-en-us' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='diretores' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='hugo-moura-en-us') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='diretores' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-diretores-hugo-moura-en-us' LIMIT 1)) WHERE slug='hugo-moura-en-us';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='hugo-moura-en-us' AND id_locale_code IS NULL;

-- Hugo Moura (82f475bc-6dfe-4989-b975-f31bf1c352fa) locale=pt_BR canonical=hugo-moura
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'jpeg-optimizer_sk_farra_final_029.jpg', 'attachment-diretores-hugo-moura-pt-br', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/jpeg","attachment_file":"jpeg-optimizer_sk_farra_final_029.jpg","attachment_path":"https://bucket.farra.media/jpeg-optimizer_sk_farra_final_029.jpg","attachment_alt":"Hugo Moura"}', 1721090136000, 1727188622574
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-diretores-hugo-moura-pt-br');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1), 'Hugo Moura', 'hugo-moura-pt-br', '', 'Baiano de Salvador, Hugo Moura é diretor, publicitário e de fotografia, e ator. Mora há 10 anos no Rio de Janeiro, onde formou-se pela Academia Internacional de Cinema (AIC). Com mais de 800 filmes publicitários no currículo, assinou campanhas para grandes marcas como Coca-Cola, Nivea, Loreal, Uber, entre outras. Hugo é especialista em publicidade e fashion films, com grande olhar fotográfico e apelo estético. Tem experiência em filmar com grandes personalidades da mídia, um diretor completo na direção de elenco, pela sua bagagem de ator, e no apelo fotográfico.', 'published', '{"order":0,"image":"https://bucket.farra.media/jpeg-optimizer_sk_farra_final_029.jpg","language":"ptbr","slug":"hugo-moura","videos":"3bafc853-df4f-4193-97e9-c59cc95cdb41","videosHome":null,"videosHomeOrder":null,"fichaTecnica":[],"socialMedia":["https://vimeo.com/dirhugomoura","https://www.imdb.com/name/nm8122831","https://www.instagram.com/hugomourag"],"reel":"3bafc853-df4f-4193-97e9-c59cc95cdb41","posttype":"diretores","legacy_id":"82f475bc-6dfe-4989-b975-f31bf1c352fa","legacy_posttype":"diretores","images":"[\"https://bucket.farra.media/MOSAICO TRABALHOS HUGO MOURA v3.png\"]"}', 1721090136000, 1721090136000, 1727188622574
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='hugo-moura-pt-br');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='hugo-moura-pt-br' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-diretores-hugo-moura-pt-br' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='hugo-moura-pt-br') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-diretores-hugo-moura-pt-br');
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM edp_posts WHERE slug='hugo-moura-pt-br' LIMIT 1), (SELECT id FROM edp_taxonomies WHERE slug='diretores' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='hugo-moura-pt-br') AND EXISTS (SELECT 1 FROM edp_taxonomies WHERE slug='diretores' AND type='category');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-diretores-hugo-moura-pt-br' LIMIT 1)) WHERE slug='hugo-moura-pt-br';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='hugo-moura-pt-br' AND id_locale_code IS NULL;

-- Garante categoria diretores nos posts migrados
INSERT OR IGNORE INTO edp_posts_taxonomies (post_id, term_id)
SELECT p.id, (SELECT id FROM edp_taxonomies WHERE slug='diretores' AND type='category' LIMIT 1)
FROM edp_posts p
INNER JOIN edp_post_types pt ON pt.id = p.post_type_id AND pt.slug = 'post'
WHERE json_extract(p.meta_values, '$.legacy_posttype') = 'diretores'
  AND NOT EXISTS (
    SELECT 1 FROM edp_posts_taxonomies px WHERE px.post_id = p.id
      AND px.term_id = (SELECT id FROM edp_taxonomies WHERE slug='diretores' AND type='category' LIMIT 1)
  );

UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='pt_BR' LIMIT 1)
WHERE post_type_id = (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1)
  AND json_extract(meta_values, '$.legacy_posttype') = 'diretores'
  AND json_extract(meta_values, '$.language') = 'ptbr'
  AND id_locale_code IS NULL;

UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1)
WHERE post_type_id = (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1)
  AND json_extract(meta_values, '$.legacy_posttype') = 'diretores'
  AND json_extract(meta_values, '$.language') = 'enUS'
  AND id_locale_code IS NULL;
