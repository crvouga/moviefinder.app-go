SELECT
	id,
	title,
	description,
	popularity,
	COALESCE(
		(SELECT url FROM media_images_mv WHERE media_id = media_mv.id AND image_type = 'poster' ORDER BY resolution_order DESC LIMIT 1),
		''
	) AS poster_url,
	COALESCE(
		(SELECT url FROM media_images_mv WHERE media_id = media_mv.id AND image_type = 'backdrop' ORDER BY resolution_order DESC LIMIT 1),
		''
	) AS backdrop_url
FROM media_mv
WHERE is_adult = false
ORDER BY popularity DESC
LIMIT $1 
OFFSET $2