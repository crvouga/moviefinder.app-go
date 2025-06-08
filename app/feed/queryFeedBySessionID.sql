WITH mapping AS (
    SELECT feed_id, session_id
    FROM feed_session_mapping
    WHERE session_id = ?
    LIMIT 1
)
SELECT 
    feed.id,
    feed.current_feed_index,
    feed.created_at_epoch,
    feed.updated_at_epoch
FROM feed
JOIN mapping ON feed.id = mapping.feed_id
ORDER BY created_at_epoch ASC
LIMIT 1;