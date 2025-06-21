-- migrate:up

DROP FUNCTION IF EXISTS public.refresh_media_mv() CASCADE;
DROP TABLE IF EXISTS public.credits CASCADE;
DROP TABLE IF EXISTS public.media CASCADE;
DROP TABLE IF EXISTS public.media_genres CASCADE;
DROP TABLE IF EXISTS public.media_images CASCADE;
DROP TABLE IF EXISTS public.media_relationships CASCADE;
DROP TABLE IF EXISTS public.people CASCADE;
DROP TABLE IF EXISTS public.videos CASCADE;

-- migrate:down

CREATE TABLE public.credits (
    id text NOT NULL,
    media_id text NOT NULL,
    person_id text NOT NULL,
    job text,
    "character" text,
    "order" integer NOT NULL,
    type text NOT NULL,
    computed_is_director integer GENERATED ALWAYS AS (
        CASE
            WHEN (lower(job) = 'director'::text) THEN 1
            ELSE 0
        END) STORED,
    computed_is_cast integer GENERATED ALWAYS AS (
        CASE
            WHEN (type = 'cast'::text) THEN 1
            ELSE 0
        END) STORED,
    CONSTRAINT credits_type_check CHECK ((type = ANY (ARRAY['cast'::text, 'crew'::text])))
);

CREATE TABLE public.media (
    id text NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    popularity double precision NOT NULL,
    release_date text NOT NULL,
    vote_average double precision NOT NULL,
    vote_count integer NOT NULL,
    runtime integer NOT NULL,
    is_adult boolean DEFAULT false NOT NULL
);

CREATE TABLE public.media_genres (
    media_id text NOT NULL,
    genre_id text NOT NULL
);

CREATE TABLE public.media_images (
    id text NOT NULL,
    media_id text NOT NULL,
    image_type text NOT NULL,
    resolution text NOT NULL,
    url text NOT NULL
);

CREATE TABLE public.media_relationships (
    id text NOT NULL,
    "from" text NOT NULL,
    "to" text NOT NULL,
    type text NOT NULL,
    "order" integer NOT NULL,
    CONSTRAINT media_relationships_type_check CHECK ((type = ANY (ARRAY['recommendation'::text, 'similar'::text])))
);

CREATE TABLE public.people (
    id text NOT NULL,
    name text NOT NULL,
    popularity double precision DEFAULT 0 NOT NULL
);
