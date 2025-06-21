SELECT
	m.id,
	m.title,
	m.description,
	m.popularity,
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
FROM media_mv m
WHERE m.is_adult = false
ORDER BY m.popularity DESC
LIMIT $1
OFFSET $2