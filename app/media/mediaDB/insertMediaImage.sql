INSERT INTO media_images (
    id,
    media_id,
    image_type,
    resolution,
    url
) VALUES ($1, $2, $3, $4, $5)
ON CONFLICT(id) DO UPDATE SET
    media_id = EXCLUDED.media_id,
    image_type = EXCLUDED.image_type,
    resolution = EXCLUDED.resolution,
    url = EXCLUDED.url 