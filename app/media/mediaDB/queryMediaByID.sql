SELECT
	m.id,
	m.title,
	m.description,
	m.popularity,
    m.poster_url,
    m.backdrop_url
FROM media_denormalized_v m
WHERE m.id = $1