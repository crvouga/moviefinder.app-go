-- migrate:up

CREATE TABLE feed (
    id TEXT PRIMARY KEY,
    current_feed_index BIGINT NOT NULL,
    created_at_epoch BIGINT NOT NULL,
    updated_at_epoch BIGINT NOT NULL
);


CREATE TABLE feed_session_mapping (
    id TEXT PRIMARY KEY,
    feed_id TEXT NOT NULL,
    session_id TEXT NOT NULL,
    created_at_epoch BIGINT NOT NULL,
    updated_at_epoch BIGINT NOT NULL,
    FOREIGN KEY (feed_id) REFERENCES feed(id)
);

CREATE INDEX idx_feed_session_mapping_feed_id ON feed_session_mapping (feed_id);
CREATE INDEX idx_feed_session_mapping_session_id ON feed_session_mapping (session_id);

-- migrate:down

DROP TABLE feed;
DROP TABLE feed_session_mapping;

