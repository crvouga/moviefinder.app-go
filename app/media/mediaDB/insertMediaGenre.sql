INSERT INTO media_genres (media_id, genre_id) VALUES ($1, $2) 
ON CONFLICT(media_id, genre_id) DO NOTHING 