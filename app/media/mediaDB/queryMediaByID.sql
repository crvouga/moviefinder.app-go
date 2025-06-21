SELECT
    id,
    title,
    description,
    popularity,
    COALESCE(
        (SELECT url FROM media_images WHERE media_id = media.id AND image_type = 'poster' LIMIT 1),
        ''
    ) AS poster_url,
    COALESCE(
        (SELECT url FROM media_images WHERE media_id = media.id AND image_type = 'backdrop' LIMIT 1),
        ''
    ) AS backdrop_url
FROM media	
WHERE id = $1