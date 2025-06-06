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
CREATE TABLE media (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    popularity REAL NOT NULL,
    release_date TEXT NOT NULL,
    vote_average REAL NOT NULL,
    vote_count INTEGER NOT NULL,
    runtime INTEGER NOT NULL
);
CREATE INDEX idx_media_popularity ON media(popularity DESC);
CREATE TABLE media_images (
    id TEXT PRIMARY KEY,
    media_id TEXT NOT NULL,
    image_type TEXT NOT NULL,
    resolution TEXT NOT NULL,
    url TEXT NOT NULL,
    FOREIGN KEY (media_id) REFERENCES media(id) ON DELETE CASCADE,
    UNIQUE(media_id, image_type, resolution)
);
CREATE INDEX idx_media_images_lookup
ON media_images(media_id, image_type, url);
CREATE TABLE genres (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL
);
CREATE TABLE media_genres (
    media_id TEXT NOT NULL,
    genre_id TEXT NOT NULL,
    FOREIGN KEY (media_id) REFERENCES media(id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE,
    PRIMARY KEY (media_id, genre_id)
);
-- Dbmate schema migrations
INSERT INTO "schema_migrations" (version) VALUES
  ('20250606035631'),
  ('20250606050831');
