INSERT INTO media (
    id,
    title,
    description,
    popularity,
    release_date,
    vote_average,
    vote_count,
    runtime,
    is_adult
) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
ON CONFLICT(id) DO UPDATE SET
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    popularity = EXCLUDED.popularity,
    release_date = EXCLUDED.release_date,
    vote_average = EXCLUDED.vote_average,
    vote_count = EXCLUDED.vote_count,
    runtime = EXCLUDED.runtime,
    is_adult = EXCLUDED.is_adult 