-- migrate:up

DROP TABLE IF EXISTS genres;

-- migrate:down

CREATE TABLE genres (
    id text NOT NULL,
    name text NOT NULL
);

ALTER TABLE ONLY genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (id);
