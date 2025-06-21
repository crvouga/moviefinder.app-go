SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: refresh_media_mv(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.refresh_media_mv() RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- First refresh without CONCURRENTLY to handle empty views
    BEGIN
        REFRESH MATERIALIZED VIEW CONCURRENTLY media_mv;
    EXCEPTION WHEN OTHERS THEN
        REFRESH MATERIALIZED VIEW media_mv;
    END;

    BEGIN
        REFRESH MATERIALIZED VIEW CONCURRENTLY media_images_mv;
    EXCEPTION WHEN OTHERS THEN
        REFRESH MATERIALIZED VIEW media_images_mv;
    END;

    BEGIN
        REFRESH MATERIALIZED VIEW CONCURRENTLY genres_mv;
    EXCEPTION WHEN OTHERS THEN
        REFRESH MATERIALIZED VIEW genres_mv;
    END;

    BEGIN
        REFRESH MATERIALIZED VIEW CONCURRENTLY media_genres_mv;
    EXCEPTION WHEN OTHERS THEN
        REFRESH MATERIALIZED VIEW media_genres_mv;
    END;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: entities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.entities (
    id text NOT NULL,
    type text NOT NULL,
    data jsonb NOT NULL,
    updated_at_epoch bigint NOT NULL
);


--
-- Name: feed; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.feed (
    id text NOT NULL,
    current_feed_index bigint NOT NULL,
    created_at_epoch bigint NOT NULL,
    updated_at_epoch bigint NOT NULL
);


--
-- Name: feed_session_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.feed_session_mapping (
    id text NOT NULL,
    feed_id text NOT NULL,
    session_id text NOT NULL,
    created_at_epoch bigint NOT NULL,
    updated_at_epoch bigint NOT NULL
);


--
-- Name: genres_mv; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.genres_mv AS
 SELECT DISTINCT id,
    (data ->> 'name'::text) AS name
   FROM public.entities ed
  WHERE (type = 'tmdb/genres/movie'::text)
  WITH NO DATA;


--
-- Name: media_genres_mv; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.media_genres_mv AS
 SELECT (ed.data ->> 'id'::text) AS media_id,
    (genre_id.value)::text AS genre_id
   FROM (public.entities ed
     CROSS JOIN LATERAL jsonb_array_elements((ed.data -> 'genre_ids'::text)) genre_id(value))
  WHERE ((ed.type = 'tmdb/movie'::text) AND (ed.data ? 'genre_ids'::text) AND (jsonb_typeof((ed.data -> 'genre_ids'::text)) = 'array'::text))
  WITH NO DATA;


--
-- Name: media_images_mv; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.media_images_mv AS
 WITH config_data AS (
         SELECT entities.data
           FROM public.entities
          WHERE ((entities.type = 'tmdb/configuration'::text) AND (entities.data ? 'images'::text) AND ((entities.data -> 'images'::text) ? 'secure_base_url'::text) AND ((entities.data -> 'images'::text) ? 'poster_sizes'::text) AND ((entities.data -> 'images'::text) ? 'backdrop_sizes'::text) AND (jsonb_typeof(((entities.data -> 'images'::text) -> 'poster_sizes'::text)) = 'array'::text) AND (jsonb_typeof(((entities.data -> 'images'::text) -> 'backdrop_sizes'::text)) = 'array'::text))
         LIMIT 1
        ), tmdb_config AS (
         SELECT ((cd.data -> 'images'::text) ->> 'secure_base_url'::text) AS base_url,
            poster_elem.value AS poster_size,
            (poster_elem.ordinality - 1) AS resolution_order,
            poster_elem.ordinality AS poster_idx
           FROM (config_data cd
             CROSS JOIN LATERAL jsonb_array_elements_text(((cd.data -> 'images'::text) -> 'poster_sizes'::text)) WITH ORDINALITY poster_elem(value, ordinality))
        ), poster_images AS (
         SELECT (((((ed.data ->> 'id'::text) || '_poster_'::text) || tc.poster_size) || '_'::text) || (tc.poster_idx - 1)) AS id,
            (ed.data ->> 'id'::text) AS media_id,
            'poster'::text AS image_type,
            tc.poster_size AS resolution,
            tc.resolution_order,
            ((tc.base_url || tc.poster_size) || (ed.data ->> 'poster_path'::text)) AS url
           FROM (public.entities ed
             CROSS JOIN tmdb_config tc)
          WHERE ((ed.type = 'tmdb/movie'::text) AND (ed.data ? 'poster_path'::text) AND ((ed.data ->> 'poster_path'::text) IS NOT NULL) AND ((ed.data ->> 'poster_path'::text) <> ''::text) AND (tc.base_url IS NOT NULL))
        ), backdrop_config AS (
         SELECT ((cd.data -> 'images'::text) ->> 'secure_base_url'::text) AS base_url,
            backdrop_elem.value AS backdrop_size,
            (backdrop_elem.ordinality - 1) AS resolution_order,
            backdrop_elem.ordinality AS backdrop_idx
           FROM (config_data cd
             CROSS JOIN LATERAL jsonb_array_elements_text(((cd.data -> 'images'::text) -> 'backdrop_sizes'::text)) WITH ORDINALITY backdrop_elem(value, ordinality))
        ), backdrop_images AS (
         SELECT (((((ed.data ->> 'id'::text) || '_backdrop_'::text) || bc.backdrop_size) || '_'::text) || (bc.backdrop_idx - 1)) AS id,
            (ed.data ->> 'id'::text) AS media_id,
            'backdrop'::text AS image_type,
            bc.backdrop_size AS resolution,
            bc.resolution_order,
            ((bc.base_url || bc.backdrop_size) || (ed.data ->> 'backdrop_path'::text)) AS url
           FROM (public.entities ed
             CROSS JOIN backdrop_config bc)
          WHERE ((ed.type = 'tmdb/movie'::text) AND (ed.data ? 'backdrop_path'::text) AND ((ed.data ->> 'backdrop_path'::text) IS NOT NULL) AND ((ed.data ->> 'backdrop_path'::text) <> ''::text) AND (bc.base_url IS NOT NULL))
        )
 SELECT poster_images.id,
    poster_images.media_id,
    poster_images.image_type,
    poster_images.resolution,
    poster_images.resolution_order,
    poster_images.url
   FROM poster_images
UNION ALL
 SELECT backdrop_images.id,
    backdrop_images.media_id,
    backdrop_images.image_type,
    backdrop_images.resolution,
    backdrop_images.resolution_order,
    backdrop_images.url
   FROM backdrop_images
  WITH NO DATA;


--
-- Name: media_mv; Type: MATERIALIZED VIEW; Schema: public; Owner: -
--

CREATE MATERIALIZED VIEW public.media_mv AS
 SELECT COALESCE((data ->> 'id'::text), md5((random())::text)) AS id,
    COALESCE((data ->> 'title'::text), ''::text) AS title,
    COALESCE((data ->> 'overview'::text), ''::text) AS description,
    COALESCE(((data ->> 'popularity'::text))::double precision, (0)::double precision) AS popularity,
    COALESCE((data ->> 'release_date'::text), ''::text) AS release_date,
    COALESCE(((data ->> 'vote_average'::text))::double precision, (0)::double precision) AS vote_average,
    COALESCE(((data ->> 'vote_count'::text))::integer, 0) AS vote_count,
    COALESCE(NULLIF(((data ->> 'runtime'::text))::integer, 0), 0) AS runtime,
    COALESCE(((data ->> 'adult'::text))::boolean, false) AS is_adult
   FROM public.entities
  WHERE ((type = 'tmdb/movie'::text) AND (data ? 'id'::text))
  WITH NO DATA;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: user_accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_accounts (
    user_id text NOT NULL,
    phone_number text NOT NULL,
    created_at_epoch bigint NOT NULL,
    last_updated_at_epoch bigint NOT NULL
);


--
-- Name: user_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_sessions (
    user_session_id text NOT NULL,
    user_id text NOT NULL,
    session_id text NOT NULL,
    created_at_epoch bigint NOT NULL,
    ended_at_epoch bigint NOT NULL
);


--
-- Name: entities entities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entities
    ADD CONSTRAINT entities_pkey PRIMARY KEY (id, type);


--
-- Name: feed feed_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feed
    ADD CONSTRAINT feed_pkey PRIMARY KEY (id);


--
-- Name: feed_session_mapping feed_session_mapping_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feed_session_mapping
    ADD CONSTRAINT feed_session_mapping_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: user_accounts user_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_accounts
    ADD CONSTRAINT user_accounts_pkey PRIMARY KEY (user_id);


--
-- Name: user_sessions user_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_pkey PRIMARY KEY (user_session_id);


--
-- Name: idx_entities_data; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_entities_data ON public.entities USING gin (data);


--
-- Name: idx_entities_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_entities_type ON public.entities USING btree (type);


--
-- Name: idx_entities_updated_at_epoch; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_entities_updated_at_epoch ON public.entities USING btree (updated_at_epoch);


--
-- Name: idx_feed_session_mapping_feed_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_feed_session_mapping_feed_id ON public.feed_session_mapping USING btree (feed_id);


--
-- Name: idx_feed_session_mapping_session_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_feed_session_mapping_session_id ON public.feed_session_mapping USING btree (session_id);


--
-- Name: idx_genres_mv_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_genres_mv_id ON public.genres_mv USING btree (id);


--
-- Name: idx_media_genres_mv_genre_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_media_genres_mv_genre_id ON public.media_genres_mv USING btree (genre_id);


--
-- Name: idx_media_genres_mv_media_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_media_genres_mv_media_id ON public.media_genres_mv USING btree (media_id);


--
-- Name: idx_media_genres_mv_pkey; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_media_genres_mv_pkey ON public.media_genres_mv USING btree (media_id, genre_id);


--
-- Name: idx_media_images_mv_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_media_images_mv_id ON public.media_images_mv USING btree (id);


--
-- Name: idx_media_images_mv_lookup; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_media_images_mv_lookup ON public.media_images_mv USING btree (media_id, image_type, url);


--
-- Name: idx_media_mv_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_media_mv_id ON public.media_mv USING btree (id);


--
-- Name: idx_media_mv_is_adult; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_media_mv_is_adult ON public.media_mv USING btree (is_adult) WHERE (is_adult = false);


--
-- Name: idx_media_mv_popularity; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_media_mv_popularity ON public.media_mv USING btree (popularity DESC);


--
-- Name: idx_user_accounts_phone_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_accounts_phone_number ON public.user_accounts USING btree (phone_number);


--
-- Name: idx_user_sessions_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_sessions_active ON public.user_sessions USING btree (session_id) WHERE (ended_at_epoch IS NOT NULL);


--
-- Name: idx_user_sessions_session_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_sessions_session_id ON public.user_sessions USING btree (session_id);


--
-- Name: feed_session_mapping feed_session_mapping_feed_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feed_session_mapping
    ADD CONSTRAINT feed_session_mapping_feed_id_fkey FOREIGN KEY (feed_id) REFERENCES public.feed(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


--
-- Dbmate schema migrations
--

INSERT INTO public.schema_migrations (version) VALUES
    ('20250606035631'),
    ('20250606050831'),
    ('20250606073703'),
    ('20250606082308'),
    ('20250620011605'),
    ('20250621052321'),
    ('20250621073938'),
    ('20250621074526'),
    ('20250621210214');
