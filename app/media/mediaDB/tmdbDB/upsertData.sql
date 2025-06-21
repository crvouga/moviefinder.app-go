INSERT INTO tmdb_data (
    id,
    type,
    data,
    inserted_at_epoch,
    updated_at_epoch
) VALUES (
    $1,
    $2,
    $3,
    $4,
    $5
) ON CONFLICT (id) DO UPDATE SET
    type = EXCLUDED.type,
    data = EXCLUDED.data,
    inserted_at_epoch = EXCLUDED.inserted_at_epoch,
    updated_at_epoch = EXCLUDED.updated_at_epoch
)