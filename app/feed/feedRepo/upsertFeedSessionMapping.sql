INSERT INTO feed_session_mapping (
    id,
    feed_id,
    session_id,
    created_at_epoch,
    updated_at_epoch
) VALUES (
    $1,
    $2,
    $3,
    EXTRACT(EPOCH FROM NOW()),
    EXTRACT(EPOCH FROM NOW())
);