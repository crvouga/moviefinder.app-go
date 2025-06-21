SELECT
    media_mv.id,
    substring(media_mv.title, 0, 50),
    media_mv.popularity
FROM media_mv
JOIN media_genres_mv ON media_mv.id = media_genres_mv.media_id
JOIN genres_mv ON media_genres_mv.genre_id = genres_mv.id
WHERE genres_mv.name ILIKE '%western%'
ORDER BY media_mv.popularity DESC
LIMIT 10;