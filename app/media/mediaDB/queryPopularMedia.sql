SELECT
    m.id,
    m.title,
    m.description,
    m.popularity,
    m.poster_url,
    m.backdrop_url
FROM media_denormalized_v m
WHERE 
		m.is_adult = false
    AND	m.poster_url IS NOT NULL
    AND	m.poster_url != ''
ORDER BY m.popularity DESC
LIMIT $1
OFFSET $2