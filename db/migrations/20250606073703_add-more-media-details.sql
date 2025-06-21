-- migrate:up

CREATE TABLE people (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    popularity DOUBLE PRECISION NOT NULL DEFAULT 0
);

CREATE INDEX idx_people_popularity ON people(popularity DESC);

CREATE TABLE media_relationships (
    id TEXT PRIMARY KEY,
    "from" TEXT NOT NULL,
    "to" TEXT NOT NULL,
    type TEXT NOT NULL,
    "order" INTEGER NOT NULL,
    CONSTRAINT media_relationships_type_check CHECK (type IN ('recommendation', 'similar')),
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
    type TEXT NOT NULL,
    computed_is_director INTEGER GENERATED ALWAYS AS (CASE WHEN LOWER(job) = 'director' THEN 1 ELSE 0 END) STORED,
    computed_is_cast INTEGER GENERATED ALWAYS AS (CASE WHEN type = 'cast' THEN 1 ELSE 0 END) STORED,
    CONSTRAINT credits_type_check CHECK (type IN ('cast', 'crew')),
    FOREIGN KEY (media_id) REFERENCES media(id) ON DELETE CASCADE,
    FOREIGN KEY (person_id) REFERENCES people(id) ON DELETE CASCADE
);

CREATE INDEX idx_credits_media ON credits(media_id, type, "order");
CREATE INDEX idx_credits_person ON credits(person_id, type);
CREATE INDEX idx_credits_director ON credits(media_id) WHERE computed_is_director = 1;
CREATE INDEX idx_credits_cast ON credits(media_id) WHERE computed_is_cast = 1;

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

-- migrate:down

DROP TABLE IF EXISTS videos;
DROP TABLE IF EXISTS credits;
DROP TABLE IF EXISTS media_relationships;
DROP TABLE IF EXISTS people;
