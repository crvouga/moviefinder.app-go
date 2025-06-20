INSERT OR REPLACE INTO media (
    id,
    title,
    description,
    popularity,
    release_date,
    vote_average,
    vote_count,
    runtime,
    is_adult
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?) 