INSERT INTO feed_session_mapping (
    feed_id,
    session_id,
    created_at_epoch,
    updated_at_epoch
) VALUES (
    ?,
    ?,
    strftime('%s', 'now'),
    strftime('%s', 'now')
);