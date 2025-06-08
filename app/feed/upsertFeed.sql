INSERT INTO feed (
    id,
    current_feed_index,
    created_at_epoch,
    updated_at_epoch
) VALUES (
    ?,
    ?,
    ?,
    ?
)
ON CONFLICT(id) DO UPDATE SET
    current_feed_index = excluded.current_feed_index,
    created_at_epoch = excluded.created_at_epoch,
    updated_at_epoch = excluded.updated_at_epoch;