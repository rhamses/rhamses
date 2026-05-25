-- Custom fields diretores: templates + migração meta_values -> posts filhos
-- Pré-requisito: migrate-diretores.sql (categoria diretores + posts)
-- Templates Redes Sociais / Reel já existem em migrate-jobs-custom-fields.sql

INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='custom_fields' LIMIT 1), 'Imagem', 'template-diretores-imagem', 'published', '{"template": true, "field_type": ["text"], "fields": [{"name": "URL", "value": "", "type": "text"}]}', 0, 0
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='template-diretores-imagem');

INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='custom_fields' LIMIT 1), 'Slug canônico', 'template-diretores-slug', 'published', '{"template": true, "field_type": ["text"], "fields": [{"name": "Slug", "value": "", "type": "text"}]}', 0, 0
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='template-diretores-slug');

-- Gui Cintra PT
INSERT OR IGNORE INTO edp_posts (post_type_id, parent_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='custom_fields' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='gui-cintra-pt-br' LIMIT 1), 'Redes Sociais', 'cf-diretores-gui-cintra-pt-br-social', 'published', '{"template": false, "field_type": ["editor"], "fields": [{"name": "URLs (JSON)", "value": "[\"https://www.linkedin.com/in/guicintra\",\"https://www.instagram.com/cintra/\",\"https://twitter.com/guicintra\"]", "type": "editor"}]}', 0, 0
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='gui-cintra-pt-br') AND NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='cf-diretores-gui-cintra-pt-br-social');

INSERT OR IGNORE INTO edp_posts (post_type_id, parent_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='custom_fields' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='gui-cintra-pt-br' LIMIT 1), 'Reel', 'cf-diretores-gui-cintra-pt-br-reel', 'published', '{"template": false, "field_type": ["text"], "fields": [{"name": "URL ou ID", "value": "1e56330a-f375-4fbd-bcfc-b9a26bc32589", "type": "text"}]}', 0, 0
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='gui-cintra-pt-br') AND NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='cf-diretores-gui-cintra-pt-br-reel');

INSERT OR IGNORE INTO edp_posts (post_type_id, parent_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='custom_fields' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='gui-cintra-pt-br' LIMIT 1), 'Imagem', 'cf-diretores-gui-cintra-pt-br-imagem', 'published', '{"template": false, "field_type": ["text"], "fields": [{"name": "URL", "value": "https://bucket.farra.media/cintra.avif", "type": "text"}]}', 0, 0
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='gui-cintra-pt-br') AND NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='cf-diretores-gui-cintra-pt-br-imagem');

-- Gui Cintra EN
INSERT OR IGNORE INTO edp_posts (post_type_id, parent_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='custom_fields' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='gui-cintra-en-us' LIMIT 1), 'Redes Sociais', 'cf-diretores-gui-cintra-en-us-social', 'published', '{"template": false, "field_type": ["editor"], "fields": [{"name": "URLs (JSON)", "value": "[\"https://www.linkedin.com/in/guicintra\",\"https://www.instagram.com/cintra/\",\"https://twitter.com/guicintra\"]", "type": "editor"}]}', 0, 0
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='gui-cintra-en-us') AND NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='cf-diretores-gui-cintra-en-us-social');

INSERT OR IGNORE INTO edp_posts (post_type_id, parent_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='custom_fields' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='gui-cintra-en-us' LIMIT 1), 'Reel', 'cf-diretores-gui-cintra-en-us-reel', 'published', '{"template": false, "field_type": ["text"], "fields": [{"name": "URL ou ID", "value": "1e56330a-f375-4fbd-bcfc-b9a26bc32589", "type": "text"}]}', 0, 0
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='gui-cintra-en-us') AND NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='cf-diretores-gui-cintra-en-us-reel');

INSERT OR IGNORE INTO edp_posts (post_type_id, parent_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='custom_fields' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='gui-cintra-en-us' LIMIT 1), 'Imagem', 'cf-diretores-gui-cintra-en-us-imagem', 'published', '{"template": false, "field_type": ["text"], "fields": [{"name": "URL", "value": "https://bucket.farra.media/cintra.avif", "type": "text"}]}', 0, 0
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='gui-cintra-en-us') AND NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='cf-diretores-gui-cintra-en-us-imagem');

-- Hugo Moura PT
INSERT OR IGNORE INTO edp_posts (post_type_id, parent_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='custom_fields' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='hugo-moura-pt-br' LIMIT 1), 'Redes Sociais', 'cf-diretores-hugo-moura-pt-br-social', 'published', '{"template": false, "field_type": ["editor"], "fields": [{"name": "URLs (JSON)", "value": "[\"https://vimeo.com/dirhugomoura\",\"https://www.imdb.com/name/nm8122831\",\"https://www.instagram.com/hugomourag\"]", "type": "editor"}]}', 0, 0
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='hugo-moura-pt-br') AND NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='cf-diretores-hugo-moura-pt-br-social');

INSERT OR IGNORE INTO edp_posts (post_type_id, parent_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='custom_fields' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='hugo-moura-pt-br' LIMIT 1), 'Reel', 'cf-diretores-hugo-moura-pt-br-reel', 'published', '{"template": false, "field_type": ["text"], "fields": [{"name": "URL ou ID", "value": "3bafc853-df4f-4193-97e9-c59cc95cdb41", "type": "text"}]}', 0, 0
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='hugo-moura-pt-br') AND NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='cf-diretores-hugo-moura-pt-br-reel');

INSERT OR IGNORE INTO edp_posts (post_type_id, parent_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='custom_fields' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='hugo-moura-pt-br' LIMIT 1), 'Imagem', 'cf-diretores-hugo-moura-pt-br-imagem', 'published', '{"template": false, "field_type": ["text"], "fields": [{"name": "URL", "value": "https://bucket.farra.media/jpeg-optimizer_sk_farra_final_029.jpg", "type": "text"}]}', 0, 0
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='hugo-moura-pt-br') AND NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='cf-diretores-hugo-moura-pt-br-imagem');

INSERT OR IGNORE INTO edp_posts (post_type_id, parent_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='custom_fields' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='hugo-moura-pt-br' LIMIT 1), 'Slug canônico', 'cf-diretores-hugo-moura-pt-br-slug', 'published', '{"template": false, "field_type": ["text"], "fields": [{"name": "Slug", "value": "hugo-moura", "type": "text"}]}', 0, 0
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='hugo-moura-pt-br') AND NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='cf-diretores-hugo-moura-pt-br-slug');

-- Hugo Moura EN
INSERT OR IGNORE INTO edp_posts (post_type_id, parent_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='custom_fields' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='hugo-moura-en-us' LIMIT 1), 'Redes Sociais', 'cf-diretores-hugo-moura-en-us-social', 'published', '{"template": false, "field_type": ["editor"], "fields": [{"name": "URLs (JSON)", "value": "[\"https://vimeo.com/dirhugomoura\",\"https://www.imdb.com/name/nm8122831\",\"https://www.instagram.com/hugomourag\"]", "type": "editor"}]}', 0, 0
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='hugo-moura-en-us') AND NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='cf-diretores-hugo-moura-en-us-social');

INSERT OR IGNORE INTO edp_posts (post_type_id, parent_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='custom_fields' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='hugo-moura-en-us' LIMIT 1), 'Reel', 'cf-diretores-hugo-moura-en-us-reel', 'published', '{"template": false, "field_type": ["text"], "fields": [{"name": "URL ou ID", "value": "3bafc853-df4f-4193-97e9-c59cc95cdb41", "type": "text"}]}', 0, 0
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='hugo-moura-en-us') AND NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='cf-diretores-hugo-moura-en-us-reel');

INSERT OR IGNORE INTO edp_posts (post_type_id, parent_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='custom_fields' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='hugo-moura-en-us' LIMIT 1), 'Imagem', 'cf-diretores-hugo-moura-en-us-imagem', 'published', '{"template": false, "field_type": ["text"], "fields": [{"name": "URL", "value": "https://bucket.farra.media/jpeg-optimizer_sk_farra_final_029.jpg", "type": "text"}]}', 0, 0
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='hugo-moura-en-us') AND NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='cf-diretores-hugo-moura-en-us-imagem');

INSERT OR IGNORE INTO edp_posts (post_type_id, parent_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='custom_fields' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='hugo-moura-en-us' LIMIT 1), 'Slug canônico', 'cf-diretores-hugo-moura-en-us-slug', 'published', '{"template": false, "field_type": ["text"], "fields": [{"name": "Slug", "value": "hugo-moura", "type": "text"}]}', 0, 0
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='hugo-moura-en-us') AND NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='cf-diretores-hugo-moura-en-us-slug');

-- Sincroniza reel legado a partir de videos quando reel estiver vazio
UPDATE edp_posts
SET meta_values = json_set(meta_values, '$.reel', json_extract(meta_values, '$.videos'))
WHERE post_type_id = (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1)
  AND json_extract(meta_values, '$.reel') IS NULL
  AND json_extract(meta_values, '$.videos') IS NOT NULL
  AND id IN (
    SELECT p.id FROM edp_posts p
    INNER JOIN edp_posts_taxonomies ptax ON ptax.post_id = p.id
    INNER JOIN edp_taxonomies t ON t.id = ptax.term_id
    WHERE t.slug = 'diretores' AND t.type = 'category'
  );
