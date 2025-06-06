-- migrate:up

CREATE TABLE user_sessions (
    user_session_id TEXT PRIMARY KEY,
    user_id TEXT NOT NULL,
    session_id TEXT NOT NULL,
    created_at_epoch BIGINT NOT NULL,
    ended_at_epoch BIGINT NOT NULL
 );

CREATE INDEX idx_user_sessions_session_id ON user_sessions(session_id);
CREATE INDEX idx_user_sessions_active ON user_sessions(session_id) WHERE ended_at_epoch IS NOT NULL;

CREATE TABLE user_accounts (
    user_id TEXT PRIMARY KEY,
    phone_number TEXT NOT NULL,
    created_at_epoch BIGINT NOT NULL,
    last_updated_at_epoch BIGINT NOT NULL
);

CREATE INDEX idx_user_accounts_phone_number ON user_accounts(phone_number);


-- migrate:down


DROP INDEX idx_user_sessions_session_id;
DROP INDEX idx_user_sessions_active;
DROP TABLE user_sessions;

DROP INDEX idx_user_accounts_phone_number;
DROP TABLE user_accounts;