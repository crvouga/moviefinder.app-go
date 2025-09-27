-- migrate:up

-- Media materialized view from TMDB data
CREATE MATERIALIZED VIEW media_mv AS
SELECT 
    COALESCE((data->>'id')::text, md5(random()::text)::text) as id,
    COALESCE(data->>'title', '') as title,
    COALESCE(data->>'overview', '') as description,
    COALESCE((data->>'popularity')::double precision, 0) as popularity,
    COALESCE(data->>'release_date', '') as release_date,
    COALESCE((data->>'vote_average')::double precision, 0) as vote_average,
    COALESCE((data->>'vote_count')::integer, 0) as vote_count,
    COALESCE(NULLIF((data->>'runtime')::integer, 0), 0) as runtime,
    COALESCE((data->>'adult')::boolean, false) as is_adult
FROM entities 
WHERE type = 'tmdb/movie'
AND data ? 'id';

CREATE UNIQUE INDEX idx_media_mv_id ON media_mv (id);
CREATE INDEX idx_media_mv_popularity ON media_mv (popularity DESC);
CREATE INDEX idx_media_mv_is_adult ON media_mv (is_adult) WHERE is_adult = false;

-- Media images materialized view from TMDB data
CREATE MATERIALIZED VIEW media_images_mv AS
WITH config_data AS (
    SELECT data
    FROM entities 
    WHERE type = 'tmdb/configuration'
    AND data ? 'images' 
    AND data->'images' ? 'secure_base_url'
    AND data->'images' ? 'poster_sizes'
    AND data->'images' ? 'backdrop_sizes'
    AND jsonb_typeof(data->'images'->'poster_sizes') = 'array'
    AND jsonb_typeof(data->'images'->'backdrop_sizes') = 'array'
    LIMIT 1
),
tmdb_config AS (
    SELECT 
        cd.data->'images'->>'secure_base_url' as base_url,
        poster_elem.value as poster_size,
        poster_elem.ordinality - 1 as resolution_order,
        poster_elem.ordinality as poster_idx
    FROM config_data cd
    CROSS JOIN LATERAL jsonb_array_elements_text(cd.data->'images'->'poster_sizes') WITH ORDINALITY AS poster_elem(value, ordinality)
),
poster_images AS (
    SELECT 
        (ed.data->>'id') || '_poster_' || tc.poster_size || '_' || (tc.poster_idx - 1) as id,
        (ed.data->>'id')::text as media_id,
        'poster' as image_type,
        tc.poster_size as resolution,
        tc.resolution_order as resolution_order,
        tc.base_url || tc.poster_size || (ed.data->>'poster_path') as url
    FROM entities ed
    CROSS JOIN tmdb_config tc
    WHERE ed.type = 'tmdb/movie'
    AND ed.data ? 'poster_path'
    AND ed.data->>'poster_path' IS NOT NULL
    AND ed.data->>'poster_path' != ''
    AND tc.base_url IS NOT NULL
),
backdrop_config AS (
    SELECT 
        cd.data->'images'->>'secure_base_url' as base_url,
        backdrop_elem.value as backdrop_size,
        backdrop_elem.ordinality - 1 as resolution_order,
        backdrop_elem.ordinality as backdrop_idx
    FROM config_data cd
    CROSS JOIN LATERAL jsonb_array_elements_text(cd.data->'images'->'backdrop_sizes') WITH ORDINALITY AS backdrop_elem(value, ordinality)
),
backdrop_images AS (
    SELECT 
        (ed.data->>'id') || '_backdrop_' || bc.backdrop_size || '_' || (bc.backdrop_idx - 1) as id,
        (ed.data->>'id')::text as media_id,
        'backdrop' as image_type,
        bc.backdrop_size as resolution,
        bc.resolution_order as resolution_order,
        bc.base_url || bc.backdrop_size || (ed.data->>'backdrop_path') as url
    FROM entities ed
    CROSS JOIN backdrop_config bc
    WHERE ed.type = 'tmdb/movie'
    AND ed.data ? 'backdrop_path'
    AND ed.data->>'backdrop_path' IS NOT NULL
    AND ed.data->>'backdrop_path' != ''
    AND bc.base_url IS NOT NULL
)
SELECT * FROM poster_images
UNION ALL
SELECT * FROM backdrop_images;

CREATE UNIQUE INDEX idx_media_images_mv_id ON media_images_mv (id);
CREATE INDEX idx_media_images_mv_lookup ON media_images_mv (media_id, image_type, url);

-- Genres materialized view from TMDB data
CREATE MATERIALIZED VIEW genres_mv AS
SELECT DISTINCT
    ed.id::text as id,
    ed.data->>'name' as name
FROM entities ed
WHERE ed.type = 'tmdb/genres/movie';

CREATE UNIQUE INDEX idx_genres_mv_id ON genres_mv (id);

-- Media genres relationship materialized view
CREATE MATERIALIZED VIEW media_genres_mv AS
SELECT 
    (ed.data->>'id')::text as media_id,
    genre_id::text as genre_id
FROM entities ed
CROSS JOIN LATERAL jsonb_array_elements(ed.data->'genre_ids') as genre_id
WHERE ed.type = 'tmdb/movie'
AND ed.data ? 'genre_ids'
AND jsonb_typeof(ed.data->'genre_ids') = 'array';

CREATE INDEX idx_media_genres_mv_media_id ON media_genres_mv (media_id);
CREATE INDEX idx_media_genres_mv_genre_id ON media_genres_mv (genre_id);
CREATE UNIQUE INDEX idx_media_genres_mv_pkey ON media_genres_mv (media_id, genre_id);


-- Create denormalized media view
CREATE VIEW media_denormalized_v AS
SELECT
  m.id,
  m.title,
  m.description,
  m.popularity,
  m.is_adult,
  COALESCE((
    SELECT url 
    FROM media_images_mv
    WHERE media_id = m.id
      AND image_type = 'poster'
    ORDER BY resolution_order DESC
    LIMIT 1
  ), '') AS poster_url,
  COALESCE((
    SELECT url
    FROM media_images_mv
    WHERE media_id = m.id
      AND image_type = 'backdrop'
    ORDER BY resolution_order DESC
    LIMIT 1
  ), '') AS backdrop_url
FROM media_mv m;

-- Refresh function to update all materialized views
CREATE OR REPLACE FUNCTION refresh_media_mv() 
RETURNS void AS $$
BEGIN
    -- First refresh without CONCURRENTLY to handle empty views
    BEGIN
        REFRESH MATERIALIZED VIEW CONCURRENTLY media_mv;
    EXCEPTION WHEN OTHERS THEN
        REFRESH MATERIALIZED VIEW media_mv;
    END;
    
    BEGIN
        REFRESH MATERIALIZED VIEW CONCURRENTLY media_images_mv;
    EXCEPTION WHEN OTHERS THEN
        REFRESH MATERIALIZED VIEW media_images_mv;
    END;
    
    BEGIN
        REFRESH MATERIALIZED VIEW CONCURRENTLY genres_mv;
    EXCEPTION WHEN OTHERS THEN
        REFRESH MATERIALIZED VIEW genres_mv;
    END;
    
    BEGIN
        REFRESH MATERIALIZED VIEW CONCURRENTLY media_genres_mv;
    EXCEPTION WHEN OTHERS THEN
        REFRESH MATERIALIZED VIEW media_genres_mv;
    END;
END;
$$ LANGUAGE plpgsql;

-- migrate:down

DROP FUNCTION IF EXISTS refresh_media_mv();
DROP VIEW IF EXISTS media_denormalized_v;
DROP MATERIALIZED VIEW IF EXISTS media_genres_mv;
DROP MATERIALIZED VIEW IF EXISTS genres_mv;  
DROP MATERIALIZED VIEW IF EXISTS media_images_mv;
DROP MATERIALIZED VIEW IF EXISTS media_mv; 