INSERT INTO entities (
    id,
    type,
    data,
    updated_at_epoch
) VALUES ($1, $2, $3, EXTRACT(EPOCH FROM NOW()))
ON CONFLICT(id, type) DO UPDATE SET
    data = EXCLUDED.data,
    updated_at_epoch = EXCLUDED.updated_at_epoch