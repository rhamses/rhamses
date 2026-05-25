-- Ícones O que fazemos EN (posttype oquefazemos, order > 0) — página /en/about
-- Fonte: farra.sql (slugs -en-us onde conflitam com PT)

-- Corporate
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'corporativo.png', 'attachment-oquefazemos-corporate', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"corporativo.png","attachment_path":"https://bucket.farra.media/corporativo.png","attachment_alt":"Corporate"}', 1773174921971, 1773174921971
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-oquefazemos-corporate');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1), 'Corporate', 'corporate', 'published', '{"videos": null, "videosHome": null, "videosHomeOrder": null, "order": 1, "fichaTecnica": [], "language": "enUS", "socialMedia": null, "reel": null, "posttype": "oquefazemos", "legacy_id": "0fcd5623-51a1-4cc4-9d34-2a4db62f2ba6", "legacy_posttype": "oquefazemos", "slug": "corporate", "image": "https://bucket.farra.media/corporativo.png"}', 1717972580000, 1717972580000, 1773174921971
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='corporate');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='corporate' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-oquefazemos-corporate' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='corporate') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-oquefazemos-corporate');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-oquefazemos-corporate' LIMIT 1)) WHERE slug='corporate';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='corporate' AND id_locale_code IS NULL;

-- BRANDED ENTERTAINMENT
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'Branded Entertainment.png', 'attachment-oquefazemos-branded-entertainment-en-us', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"Branded Entertainment.png","attachment_path":"https://bucket.farra.media/Branded Entertainment.png","attachment_alt":"BRANDED ENTERTAINMENT"}', 1775833173844, 1775833173844
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-oquefazemos-branded-entertainment-en-us');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1), 'BRANDED ENTERTAINMENT', 'branded-entertainment-en-us', 'published', '{"videos": null, "videosHome": null, "videosHomeOrder": null, "order": 2, "fichaTecnica": [], "language": "enUS", "socialMedia": null, "reel": null, "posttype": "oquefazemos", "legacy_id": "84aa6bb7-1d03-4f5c-8c5f-02b3a1799b1b", "legacy_posttype": "oquefazemos", "slug": "branded-entertainment", "image": "https://bucket.farra.media/Branded Entertainment.png"}', 1717972719000, 1717972719000, 1775833173844
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='branded-entertainment-en-us');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='branded-entertainment-en-us' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-oquefazemos-branded-entertainment-en-us' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='branded-entertainment-en-us') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-oquefazemos-branded-entertainment-en-us');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-oquefazemos-branded-entertainment-en-us' LIMIT 1)) WHERE slug='branded-entertainment-en-us';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='branded-entertainment-en-us' AND id_locale_code IS NULL;

-- Advertising
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'publicidade.png', 'attachment-oquefazemos-advertising', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"publicidade.png","attachment_path":"https://bucket.farra.media/publicidade.png","attachment_alt":"Advertising"}', 1773174912583, 1773174912583
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-oquefazemos-advertising');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1), 'Advertising', 'advertising', 'published', '{"videos": null, "videosHome": null, "videosHomeOrder": null, "order": 3, "fichaTecnica": [], "language": "enUS", "socialMedia": null, "reel": null, "posttype": "oquefazemos", "legacy_id": "e0b7e457-5f5c-4d7a-8d6d-6e7f9b324b2d", "legacy_posttype": "oquefazemos", "slug": "advertising", "image": "https://bucket.farra.media/publicidade.png"}', 1717972704000, 1717972704000, 1773174912583
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='advertising');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='advertising' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-oquefazemos-advertising' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='advertising') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-oquefazemos-advertising');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-oquefazemos-advertising' LIMIT 1)) WHERE slug='advertising';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='advertising' AND id_locale_code IS NULL;

-- Podcasts
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'podcast.png', 'attachment-oquefazemos-podcasts-en-us', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"podcast.png","attachment_path":"https://bucket.farra.media/podcast.png","attachment_alt":"Podcasts"}', 1773174893868, 1773174893868
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-oquefazemos-podcasts-en-us');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1), 'Podcasts', 'podcasts-en-us', 'published', '{"videos": null, "videosHome": null, "videosHomeOrder": null, "order": 4, "fichaTecnica": [], "language": "enUS", "socialMedia": null, "reel": null, "posttype": "oquefazemos", "legacy_id": "0a4a8ff0-6c7b-446f-b18b-53d070ba9d9c", "legacy_posttype": "oquefazemos", "slug": "podcasts", "image": "https://bucket.farra.media/podcast.png"}', 1717972695000, 1717972695000, 1773174893868
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='podcasts-en-us');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='podcasts-en-us' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-oquefazemos-podcasts-en-us' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='podcasts-en-us') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-oquefazemos-podcasts-en-us');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-oquefazemos-podcasts-en-us' LIMIT 1)) WHERE slug='podcasts-en-us';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='podcasts-en-us' AND id_locale_code IS NULL;

-- Cinema
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'cinema.png', 'attachment-oquefazemos-cinema-en-us', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"cinema.png","attachment_path":"https://bucket.farra.media/cinema.png","attachment_alt":"Cinema"}', 1773174847302, 1773174847302
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-oquefazemos-cinema-en-us');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1), 'Cinema', 'cinema-en-us', 'published', '{"videos": null, "videosHome": null, "videosHomeOrder": null, "order": 5, "fichaTecnica": [], "language": "enUS", "socialMedia": null, "reel": null, "posttype": "oquefazemos", "legacy_id": "b8ad1e69-e607-4bcb-9ffd-77dc6872d5c0", "legacy_posttype": "oquefazemos", "slug": "cinema", "image": "https://bucket.farra.media/cinema.png"}', 1717972629000, 1717972629000, 1773174847302
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='cinema-en-us');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='cinema-en-us' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-oquefazemos-cinema-en-us' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='cinema-en-us') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-oquefazemos-cinema-en-us');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-oquefazemos-cinema-en-us' LIMIT 1)) WHERE slug='cinema-en-us';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='cinema-en-us' AND id_locale_code IS NULL;

-- Social Media
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'midia-social.png', 'attachment-oquefazemos-social-media', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"midia-social.png","attachment_path":"https://bucket.farra.media/midia-social.png","attachment_alt":"Social Media"}', 1773174827991, 1773174827991
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-oquefazemos-social-media');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1), 'Social Media', 'social-media', 'published', '{"videos": null, "videosHome": null, "videosHomeOrder": null, "order": 6, "fichaTecnica": [], "language": "enUS", "socialMedia": null, "reel": null, "posttype": "oquefazemos", "legacy_id": "d8b81c50-5606-410b-8d95-52d86b765312", "legacy_posttype": "oquefazemos", "slug": "social-media", "image": "https://bucket.farra.media/midia-social.png"}', 1717972621000, 1717972621000, 1773174827991
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='social-media');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='social-media' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-oquefazemos-social-media' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='social-media') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-oquefazemos-social-media');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-oquefazemos-social-media' LIMIT 1)) WHERE slug='social-media';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='social-media' AND id_locale_code IS NULL;

-- Lives and Events
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'instagram-ao-vivo.png', 'attachment-oquefazemos-lives-and-events', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"instagram-ao-vivo.png","attachment_path":"https://bucket.farra.media/instagram-ao-vivo.png","attachment_alt":"Lives and Events"}', 1773174782386, 1773174782386
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-oquefazemos-lives-and-events');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1), 'Lives and Events', 'lives-and-events', 'published', '{"videos": null, "videosHome": null, "videosHomeOrder": null, "order": 7, "fichaTecnica": [], "language": "enUS", "socialMedia": null, "reel": null, "posttype": "oquefazemos", "legacy_id": "3d31dcf2-1ea5-4444-aab7-6c4c7b6bda1a", "legacy_posttype": "oquefazemos", "slug": "lives-and-events", "image": "https://bucket.farra.media/instagram-ao-vivo.png"}', 1717972598000, 1717972598000, 1773174782386
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='lives-and-events');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='lives-and-events' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-oquefazemos-lives-and-events' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='lives-and-events') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-oquefazemos-lives-and-events');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-oquefazemos-lives-and-events' LIMIT 1)) WHERE slug='lives-and-events';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='lives-and-events' AND id_locale_code IS NULL;

-- TV AND STREAMING
INSERT OR IGNORE INTO edp_posts (post_type_id, title, slug, status, meta_values, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='attachment' LIMIT 1), 'televisao.png', 'attachment-oquefazemos-tv-and-streaming', 'published', '{"show_in_menu":false,"menu_options":[],"icon":"line-md:file","mime_type":"image/png","attachment_file":"televisao.png","attachment_path":"https://bucket.farra.media/televisao.png","attachment_alt":"TV AND STREAMING"}', 1773173713181, 1773173713181
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-oquefazemos-tv-and-streaming');
INSERT OR IGNORE INTO edp_posts (post_type_id, id_locale_code, title, slug, status, meta_values, published_at, created_at, updated_at)
SELECT (SELECT id FROM edp_post_types WHERE slug='post' LIMIT 1), (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1), 'TV AND STREAMING', 'tv-and-streaming', 'published', '{"videos": null, "videosHome": null, "videosHomeOrder": null, "order": 8, "fichaTecnica": [], "language": "enUS", "socialMedia": null, "reel": null, "posttype": "oquefazemos", "legacy_id": "5af7650d-d3a1-4f36-a804-51c13e270ae9", "legacy_posttype": "oquefazemos", "slug": "tv-and-streaming", "image": "https://bucket.farra.media/televisao.png"}', 1717972731000, 1717972731000, 1773173713181
WHERE NOT EXISTS (SELECT 1 FROM edp_posts WHERE slug='tv-and-streaming');
INSERT OR IGNORE INTO edp_posts_media (post_id, media_id)
SELECT (SELECT id FROM edp_posts WHERE slug='tv-and-streaming' LIMIT 1), (SELECT id FROM edp_posts WHERE slug='attachment-oquefazemos-tv-and-streaming' LIMIT 1)
WHERE EXISTS (SELECT 1 FROM edp_posts WHERE slug='tv-and-streaming') AND EXISTS (SELECT 1 FROM edp_posts WHERE slug='attachment-oquefazemos-tv-and-streaming');
UPDATE edp_posts SET meta_values = json_set(meta_values, '$.post_thumbnail_id', (SELECT CAST(id AS TEXT) FROM edp_posts WHERE slug='attachment-oquefazemos-tv-and-streaming' LIMIT 1)) WHERE slug='tv-and-streaming';
UPDATE edp_posts SET id_locale_code = (SELECT id FROM edp_locales WHERE locale_code='en_US' LIMIT 1) WHERE slug='tv-and-streaming' AND id_locale_code IS NULL;
