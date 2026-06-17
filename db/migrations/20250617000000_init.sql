-- migrate:up

CREATE SCHEMA IF NOT EXISTS moviefinder_app_go;

CREATE TABLE moviefinder_app_go.user_sessions (
    user_session_id TEXT PRIMARY KEY,
    user_id TEXT NOT NULL,
    session_id TEXT NOT NULL,
    created_at_epoch BIGINT NOT NULL,
    ended_at_epoch BIGINT NOT NULL
);

CREATE INDEX idx_user_sessions_session_id ON moviefinder_app_go.user_sessions (session_id);
CREATE INDEX idx_user_sessions_active ON moviefinder_app_go.user_sessions (session_id)
    WHERE ended_at_epoch IS NOT NULL;

CREATE TABLE moviefinder_app_go.user_accounts (
    user_id TEXT PRIMARY KEY,
    phone_number TEXT NOT NULL,
    created_at_epoch BIGINT NOT NULL,
    last_updated_at_epoch BIGINT NOT NULL
);

CREATE INDEX idx_user_accounts_phone_number ON moviefinder_app_go.user_accounts (phone_number);

CREATE TABLE moviefinder_app_go.feed (
    id TEXT PRIMARY KEY,
    current_feed_index BIGINT NOT NULL,
    created_at_epoch BIGINT NOT NULL,
    updated_at_epoch BIGINT NOT NULL
);

CREATE TABLE moviefinder_app_go.feed_session_mapping (
    id TEXT PRIMARY KEY,
    feed_id TEXT NOT NULL,
    session_id TEXT NOT NULL,
    created_at_epoch BIGINT NOT NULL,
    updated_at_epoch BIGINT NOT NULL,
    FOREIGN KEY (feed_id) REFERENCES moviefinder_app_go.feed (id) ON DELETE CASCADE
);

CREATE INDEX idx_feed_session_mapping_feed_id ON moviefinder_app_go.feed_session_mapping (feed_id);
CREATE INDEX idx_feed_session_mapping_session_id ON moviefinder_app_go.feed_session_mapping (session_id);

CREATE TABLE moviefinder_app_go.entities (
    id TEXT NOT NULL,
    type TEXT NOT NULL,
    data JSONB NOT NULL,
    updated_at_epoch BIGINT NOT NULL,
    PRIMARY KEY (id, type)
);

CREATE INDEX idx_entities_type ON moviefinder_app_go.entities (type);
CREATE INDEX idx_entities_updated_at_epoch ON moviefinder_app_go.entities (updated_at_epoch);
CREATE INDEX idx_entities_data ON moviefinder_app_go.entities USING GIN (data);

-- migrate:down

DROP SCHEMA moviefinder_app_go CASCADE;
