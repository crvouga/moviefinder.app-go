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
CREATE TABLE media_relationships (
    id TEXT PRIMARY KEY,
    "from" TEXT NOT NULL,
    "to" TEXT NOT NULL,
    type TEXT CHECK (type IN ('recommendation', 'similar')) NOT NULL,
    "order" INTEGER NOT NULL,
    FOREIGN KEY ("from") REFERENCES media(id) ON DELETE CASCADE,
    FOREIGN KEY ("to") REFERENCES media(id) ON DELETE CASCADE
);
CREATE INDEX idx_media_relationships_from ON media_relationships("from", type, "order");
CREATE INDEX idx_media_relationships_to ON media_relationships("to", type, "order");
CREATE TABLE credits (
    id TEXT PRIMARY KEY,
    media_id TEXT NOT NULL,
    person_id TEXT NOT NULL,
    job TEXT,
    character TEXT,
    "order" INTEGER NOT NULL,
    type TEXT CHECK (type IN ('cast', 'crew')) NOT NULL,
    computed_is_director INTEGER GENERATED ALWAYS AS (CASE WHEN lower(job) = 'director' THEN 1 ELSE 0 END) STORED NOT NULL,
    computed_is_cast INTEGER GENERATED ALWAYS AS (CASE WHEN type = 'cast' THEN 1 ELSE 0 END) STORED NOT NULL,
    FOREIGN KEY (media_id) REFERENCES media(id) ON DELETE CASCADE,
    FOREIGN KEY (person_id) REFERENCES people(id) ON DELETE CASCADE
);
CREATE INDEX idx_credits_media ON credits(media_id, type, "order");
CREATE INDEX idx_credits_person ON credits(person_id, type);
CREATE INDEX idx_credits_director ON credits(media_id) WHERE computed_is_director = 1;
CREATE INDEX idx_credits_cast ON credits(media_id) WHERE computed_is_cast = 1;
CREATE TABLE people (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    popularity REAL NOT NULL DEFAULT 0
);
CREATE INDEX idx_people_popularity ON people(popularity DESC);
CREATE TABLE videos (
    id TEXT PRIMARY KEY,
    iso_639_1 TEXT NOT NULL,
    iso_3166_1 TEXT NOT NULL,
    name TEXT NOT NULL,
    key TEXT NOT NULL,
    site TEXT NOT NULL,
    size INTEGER NOT NULL,
    type TEXT NOT NULL,
    official BOOLEAN NOT NULL DEFAULT false,
    published_at TEXT NOT NULL,
    media_id TEXT NOT NULL,
    "order" INTEGER NOT NULL,
    FOREIGN KEY (media_id) REFERENCES media(id) ON DELETE CASCADE
);
CREATE INDEX idx_videos_media ON videos(media_id, type, "order");
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
-- Dbmate schema migrations
INSERT INTO "schema_migrations" (version) VALUES
  ('20250606035631'),
  ('20250606050831'),
  ('20250606073703'),
  ('20250606082308');
