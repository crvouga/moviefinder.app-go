-- migrate:up

CREATE TABLE media (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    popularity DOUBLE PRECISION NOT NULL,
    release_date TEXT NOT NULL,
    vote_average DOUBLE PRECISION NOT NULL,
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

-- migrate:down

DROP TABLE IF EXISTS media_genres;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS media_images;
DROP TABLE IF EXISTS media;
