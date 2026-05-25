-- Migração serviços (SonicJS -> EdgePress)
-- Intro legado posttype=servicos -> post type page (2 páginas PT/EN)
-- Itens legado tiposervicos -> post type post + categoria servicos (12 itens)
-- Pré-requisito: seed (post, page, taxonomies categoria, locales pt_BR/en_US)

-- Categoria "servicos" filha de "categoria"
INSERT OR IGNORE INTO taxonomies (name, slug, type, parent_id, created_at, updated_at)
SELECT 'Serviços', 'servicos', 'category', (SELECT id FROM taxonomies WHERE slug='categoria' LIMIT 1), 0, 0
WHERE NOT EXISTS (SELECT 1 FROM taxonomies WHERE slug='servicos' AND type='category');

-- Serviços — página intro PT (bfbc93a6-085d-49bf-9a0e-8c6bf15a258b)
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='page' LIMIT 1), (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1), 'Serviços', 'servicos-pt-br', '', 'Estamos preparados para atender todas as etapas de um projeto audiovisual, desde a sua criação até a entrega final, além de também oferecermos serviços fragmentados para atender a demandas específicas. Podemos, por exemplo, cuidar apenas da criação, apenas do roteiro, apenas da produção ou apenas da pós-produção.', 'published', '{"order":0,"language":"ptbr","videos":null,"fichaTecnica":[],"socialMedia":null,"posttype":"servicos","legacy_id":"bfbc93a6-085d-49bf-9a0e-8c6bf15a258b","legacy_posttype":"servicos"}', 1716338064383, 1716338064383, 1716338064383
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='servicos-pt-br');
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='servicos-pt-br' AND id_locale_code IS NULL;

-- Services — página intro EN (ef621f9b-1f8e-47e5-8310-888b0fbfd51e)
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='page' LIMIT 1), (SELECT id FROM locales WHERE locale_code='en_US' LIMIT 1), 'Services', 'services-en-us', '', 'We are prepared to handle all stages of an audiovisual project, from its inception to final delivery, as well as offering fragmented services to meet specific demands. For example, we can take care of only the creation, only the screenplay, only the production, or only the post-production.', 'published', '{"order":0,"language":"enUS","videos":null,"fichaTecnica":[],"socialMedia":null,"posttype":"servicos","legacy_id":"ef621f9b-1f8e-47e5-8310-888b0fbfd51e","legacy_posttype":"servicos"}', 1716338449099, 1716338449099, 1716338449099
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='services-en-us');
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='services-en-us' AND id_locale_code IS NULL;

-- Artist Management (b026f66b-0bdf-4181-9be6-f0ecb9f3d6b0) locale=en_US
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='post' LIMIT 1), (SELECT id FROM locales WHERE locale_code='en_US' LIMIT 1), 'Artist Management', 'artist-management-en-us', '', 'We collaborate with brands and special projects by connecting the right name to communicate with the desired audience. Additionally, we work alongside influencers and celebrities in developing tailored content for each talent, stitching partnerships and opportunities together.', 'published', '{"order":0,"language":"enUS","videos":null,"fichaTecnica":[],"socialMedia":null,"posttype":"servicos","legacy_id":"b026f66b-0bdf-4181-9be6-f0ecb9f3d6b0","legacy_posttype":"tiposervicos"}', 1716338204107, 1716338204107, 1716338204107
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='artist-management-en-us');
INSERT OR IGNORE INTO posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM posts WHERE slug='artist-management-en-us' LIMIT 1), (SELECT id FROM taxonomies WHERE slug='servicos' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='artist-management-en-us') AND EXISTS (SELECT 1 FROM taxonomies WHERE slug='servicos' AND type='category');
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='artist-management-en-us' AND id_locale_code IS NULL;

-- Creation and Scriptwriting (3f91be34-2af3-416a-97d6-036631b496da) locale=en_US
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='post' LIMIT 1), (SELECT id FROM locales WHERE locale_code='en_US' LIMIT 1), 'Creation and Scriptwriting', 'creation-and-scriptwriting-en-us', '', 'Farra''s scriptwriting room is composed of diverse and versatile professionals to cater to a wide range of genres and formats, from a fiction drama to a non-fiction reality show, from a social media video to a branded content series.', 'published', '{"order":0,"language":"enUS","videos":null,"fichaTecnica":[],"socialMedia":null,"posttype":"servicos","legacy_id":"3f91be34-2af3-416a-97d6-036631b496da","legacy_posttype":"tiposervicos"}', 1716338368520, 1716338368520, 1716338368520
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='creation-and-scriptwriting-en-us');
INSERT OR IGNORE INTO posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM posts WHERE slug='creation-and-scriptwriting-en-us' LIMIT 1), (SELECT id FROM taxonomies WHERE slug='servicos' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='creation-and-scriptwriting-en-us') AND EXISTS (SELECT 1 FROM taxonomies WHERE slug='servicos' AND type='category');
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='creation-and-scriptwriting-en-us' AND id_locale_code IS NULL;

-- Criação e Roteiro (bc9678a1-c3c4-468c-b826-8378b795f36f) locale=pt_BR
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='post' LIMIT 1), (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1), 'Criação e Roteiro', 'criacao-e-roteiro-pt-br', '', 'A sala de roteiro da Farra é formada por profissionais diversos e versáteis para atender a um amplo número de gêneros e formatos, de um drama de ficção a um reality show de não-ficção, de um vídeo para social media a uma série de branded content.', 'published', '{"order":0,"language":"ptbr","videos":null,"fichaTecnica":[],"socialMedia":null,"posttype":"servicos","legacy_id":"bc9678a1-c3c4-468c-b826-8378b795f36f","legacy_posttype":"tiposervicos"}', 1716338112400, 1716338112400, 1716338112400
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='criacao-e-roteiro-pt-br');
INSERT OR IGNORE INTO posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM posts WHERE slug='criacao-e-roteiro-pt-br' LIMIT 1), (SELECT id FROM taxonomies WHERE slug='servicos' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='criacao-e-roteiro-pt-br') AND EXISTS (SELECT 1 FROM taxonomies WHERE slug='servicos' AND type='category');
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='criacao-e-roteiro-pt-br' AND id_locale_code IS NULL;

-- Estratégia (c8d31181-4628-4b93-ace9-f80fe147d20f) locale=pt_BR
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='post' LIMIT 1), (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1), 'Estratégia', 'estrategia-pt-br', '', 'Planejamento estratégico para criação de campanhas e projetos especiais de branded content e entertainment.', 'published', '{"order":0,"language":"ptbr","videos":null,"fichaTecnica":[],"socialMedia":null,"posttype":"servicos","legacy_id":"c8d31181-4628-4b93-ace9-f80fe147d20f","legacy_posttype":"tiposervicos"}', 1716338104607, 1716338104607, 1716338104607
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='estrategia-pt-br');
INSERT OR IGNORE INTO posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM posts WHERE slug='estrategia-pt-br' LIMIT 1), (SELECT id FROM taxonomies WHERE slug='servicos' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='estrategia-pt-br') AND EXISTS (SELECT 1 FROM taxonomies WHERE slug='servicos' AND type='category');
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='estrategia-pt-br' AND id_locale_code IS NULL;

-- Mídias Sociais (6ae23b67-6610-4780-b53c-908d0b332b05) locale=pt_BR
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='post' LIMIT 1), (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1), 'Mídias Sociais', 'midias-sociais-pt-br', '', 'Planejamento, criação de conteúdo, gerenciamento de postagens e análise de resultados para canais, perfis e páginas.', 'published', '{"order":0,"language":"ptbr","videos":null,"fichaTecnica":[],"socialMedia":null,"posttype":"servicos","legacy_id":"6ae23b67-6610-4780-b53c-908d0b332b05","legacy_posttype":"tiposervicos"}', 1716338081044, 1716338081044, 1716338081044
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='midias-sociais-pt-br');
INSERT OR IGNORE INTO posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM posts WHERE slug='midias-sociais-pt-br' LIMIT 1), (SELECT id FROM taxonomies WHERE slug='servicos' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='midias-sociais-pt-br') AND EXISTS (SELECT 1 FROM taxonomies WHERE slug='servicos' AND type='category');
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='midias-sociais-pt-br' AND id_locale_code IS NULL;

-- Post-production (19a1790a-6bc8-4bb9-b75f-8f02156fc5a8) locale=en_US
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='post' LIMIT 1), (SELECT id FROM locales WHERE locale_code='en_US' LIMIT 1), 'Post-production', 'post-production-en-us', '', 'Farra''s post-production team consists of specialists prepared to handle all stages: editing, motion graphics (animations), sound design, and color grading.', 'published', '{"order":0,"language":"enUS","videos":null,"fichaTecnica":[],"socialMedia":null,"posttype":"servicos","legacy_id":"19a1790a-6bc8-4bb9-b75f-8f02156fc5a8","legacy_posttype":"tiposervicos"}', 1716338351001, 1716338351001, 1716338351001
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='post-production-en-us');
INSERT OR IGNORE INTO posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM posts WHERE slug='post-production-en-us' LIMIT 1), (SELECT id FROM taxonomies WHERE slug='servicos' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='post-production-en-us') AND EXISTS (SELECT 1 FROM taxonomies WHERE slug='servicos' AND type='category');
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='post-production-en-us' AND id_locale_code IS NULL;

-- Production (f49cdf63-54b4-4215-94c6-82d1f0553e52) locale=en_US
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='post' LIMIT 1), (SELECT id FROM locales WHERE locale_code='en_US' LIMIT 1), 'Production', 'production-en-us', '', 'Versatile and intelligent production service, ready to operate in a lightweight, efficient, agile, and high-volume manner, with a full understanding of digital demands and in synergy with creative demands.', 'published', '{"order":0,"language":"enUS","videos":null,"fichaTecnica":[],"socialMedia":null,"posttype":"servicos","legacy_id":"f49cdf63-54b4-4215-94c6-82d1f0553e52","legacy_posttype":"tiposervicos"}', 1716338434727, 1716338434727, 1716338434727
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='production-en-us');
INSERT OR IGNORE INTO posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM posts WHERE slug='production-en-us' LIMIT 1), (SELECT id FROM taxonomies WHERE slug='servicos' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='production-en-us') AND EXISTS (SELECT 1 FROM taxonomies WHERE slug='servicos' AND type='category');
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='production-en-us' AND id_locale_code IS NULL;

-- Produção (b09ce844-3f75-481e-9fe0-9eb25f06125e) locale=pt_BR
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='post' LIMIT 1), (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1), 'Produção', 'producao-pt-br', '', 'Serviço de produção versátil e inteligente, preparado para atuar de forma leve, eficiente, ágil e volumosa, com compreensão total das demandas digitais e em sinergia com as demandas criativas.', 'published', '{"order":0,"language":"ptbr","videos":null,"fichaTecnica":[],"socialMedia":null,"posttype":"servicos","legacy_id":"b09ce844-3f75-481e-9fe0-9eb25f06125e","legacy_posttype":"tiposervicos"}', 1716338178619, 1716338178619, 1716338178619
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='producao-pt-br');
INSERT OR IGNORE INTO posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM posts WHERE slug='producao-pt-br' LIMIT 1), (SELECT id FROM taxonomies WHERE slug='servicos' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='producao-pt-br') AND EXISTS (SELECT 1 FROM taxonomies WHERE slug='servicos' AND type='category');
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='producao-pt-br' AND id_locale_code IS NULL;

-- Produção Artística (edd68797-d5c6-4625-a490-c84da9511099) locale=pt_BR
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='post' LIMIT 1), (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1), 'Produção Artística', 'producao-artistica-pt-br', '', 'Colaboramos com marcas e projetos especiais conectando o nome certo para falar com o público desejado. Além disso, atuamos junto a influenciadores e celebridades no desenvolvimento de conteúdos direcionados para cada talento, costurando parcerias e oportunidades. ', 'published', '{"order":0,"language":"ptbr","videos":null,"fichaTecnica":[],"socialMedia":null,"posttype":"servicos","legacy_id":"edd68797-d5c6-4625-a490-c84da9511099","legacy_posttype":"tiposervicos"}', 1716338072223, 1716338072223, 1716338072223
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='producao-artistica-pt-br');
INSERT OR IGNORE INTO posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM posts WHERE slug='producao-artistica-pt-br' LIMIT 1), (SELECT id FROM taxonomies WHERE slug='servicos' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='producao-artistica-pt-br') AND EXISTS (SELECT 1 FROM taxonomies WHERE slug='servicos' AND type='category');
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='producao-artistica-pt-br' AND id_locale_code IS NULL;

-- Pós-Produção (14c6c6db-a667-4724-bf02-c41675883d26) locale=pt_BR
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='post' LIMIT 1), (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1), 'Pós-Produção', 'pos-producao-pt-br', '', 'A equipe de pós-produção da Farra conta com especialistas preparados para atender a todas as etapas: montagem (edição), motion graphic (animações), sonorização e tratamento de cor.', 'published', '{"order":0,"language":"ptbr","videos":null,"fichaTecnica":[],"socialMedia":null,"posttype":"servicos","legacy_id":"14c6c6db-a667-4724-bf02-c41675883d26","legacy_posttype":"tiposervicos"}', 1716338094051, 1716338094051, 1716338094051
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='pos-producao-pt-br');
INSERT OR IGNORE INTO posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM posts WHERE slug='pos-producao-pt-br' LIMIT 1), (SELECT id FROM taxonomies WHERE slug='servicos' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='pos-producao-pt-br') AND EXISTS (SELECT 1 FROM taxonomies WHERE slug='servicos' AND type='category');
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='pt_BR' LIMIT 1) WHERE slug='pos-producao-pt-br' AND id_locale_code IS NULL;

-- Social Media (d8c00d49-fea1-4969-b943-46230315259d) locale=en_US
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='post' LIMIT 1), (SELECT id FROM locales WHERE locale_code='en_US' LIMIT 1), 'Social Media', 'social-media-en-us', '', 'Planning, content creation, post management, and result analysis for channels, profiles, and pages.', 'published', '{"order":0,"language":"enUS","videos":null,"fichaTecnica":[],"socialMedia":null,"posttype":"servicos","legacy_id":"d8c00d49-fea1-4969-b943-46230315259d","legacy_posttype":"tiposervicos"}', 1716338330655, 1716338330655, 1716338330655
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='social-media-en-us');
INSERT OR IGNORE INTO posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM posts WHERE slug='social-media-en-us' LIMIT 1), (SELECT id FROM taxonomies WHERE slug='servicos' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='social-media-en-us') AND EXISTS (SELECT 1 FROM taxonomies WHERE slug='servicos' AND type='category');
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='social-media-en-us' AND id_locale_code IS NULL;

-- Strategy (5eef7592-8700-4350-9b6d-326bfbb631e9) locale=en_US
INSERT OR IGNORE INTO posts (post_type_id, id_locale_code, title, slug, excerpt, body, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM post_types WHERE slug='post' LIMIT 1), (SELECT id FROM locales WHERE locale_code='en_US' LIMIT 1), 'Strategy', 'strategy-en-us', '', 'Strategic planning for the creation of campaigns and special projects in branded content and entertainment.', 'published', '{"order":0,"language":"enUS","videos":null,"fichaTecnica":[],"socialMedia":null,"posttype":"servicos","legacy_id":"5eef7592-8700-4350-9b6d-326bfbb631e9","legacy_posttype":"tiposervicos"}', 1716338360188, 1716338360188, 1716338360188
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE slug='strategy-en-us');
INSERT OR IGNORE INTO posts_taxonomies (post_id, term_id)
SELECT (SELECT id FROM posts WHERE slug='strategy-en-us' LIMIT 1), (SELECT id FROM taxonomies WHERE slug='servicos' AND type='category' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM posts WHERE slug='strategy-en-us') AND EXISTS (SELECT 1 FROM taxonomies WHERE slug='servicos' AND type='category');
UPDATE posts SET id_locale_code = (SELECT id FROM locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='strategy-en-us' AND id_locale_code IS NULL;

-- Garante categoria servicos nos posts migrados
INSERT OR IGNORE INTO posts_taxonomies (post_id, term_id)
SELECT p.id, (SELECT id FROM taxonomies WHERE slug='servicos' AND type='category' LIMIT 1)
FROM posts p
INNER JOIN post_types pt ON pt.id = p.post_type_id AND pt.slug = 'post'
WHERE json_extract(p.meta_values, '$.legacy_posttype') = 'tiposervicos'
  AND NOT EXISTS (
    SELECT 1 FROM posts_taxonomies px WHERE px.post_id = p.id
      AND px.term_id = (SELECT id FROM taxonomies WHERE slug='servicos' AND type='category' LIMIT 1)
  );