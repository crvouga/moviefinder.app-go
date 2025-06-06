CREATE TABLE IF NOT EXISTS "schema_migrations" (version varchar(128) primary key);
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
-- Dbmate schema migrations
INSERT INTO "schema_migrations" (version) VALUES
  ('20250606035631');
