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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: credits; Type: TABLE; Schema: public; Owner: -
--

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


--
-- Name: external_data; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.external_data (
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
-- Name: genres; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.genres (
    id text NOT NULL,
    name text NOT NULL
);


--
-- Name: media; Type: TABLE; Schema: public; Owner: -
--

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


--
-- Name: media_genres; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.media_genres (
    media_id text NOT NULL,
    genre_id text NOT NULL
);


--
-- Name: media_images; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.media_images (
    id text NOT NULL,
    media_id text NOT NULL,
    image_type text NOT NULL,
    resolution text NOT NULL,
    url text NOT NULL
);


--
-- Name: media_relationships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.media_relationships (
    id text NOT NULL,
    "from" text NOT NULL,
    "to" text NOT NULL,
    type text NOT NULL,
    "order" integer NOT NULL,
    CONSTRAINT media_relationships_type_check CHECK ((type = ANY (ARRAY['recommendation'::text, 'similar'::text])))
);


--
-- Name: people; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.people (
    id text NOT NULL,
    name text NOT NULL,
    popularity double precision DEFAULT 0 NOT NULL
);


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
-- Name: videos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.videos (
    id text NOT NULL,
    iso_639_1 text NOT NULL,
    iso_3166_1 text NOT NULL,
    name text NOT NULL,
    key text NOT NULL,
    site text NOT NULL,
    size integer NOT NULL,
    type text NOT NULL,
    official boolean DEFAULT false NOT NULL,
    published_at text NOT NULL,
    media_id text NOT NULL,
    "order" integer NOT NULL
);


--
-- Name: credits credits_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credits
    ADD CONSTRAINT credits_pkey PRIMARY KEY (id);


--
-- Name: external_data external_data_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.external_data
    ADD CONSTRAINT external_data_pkey PRIMARY KEY (id, type);


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
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (id);


--
-- Name: media_genres media_genres_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_genres
    ADD CONSTRAINT media_genres_pkey PRIMARY KEY (media_id, genre_id);


--
-- Name: media_images media_images_media_id_image_type_resolution_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_images
    ADD CONSTRAINT media_images_media_id_image_type_resolution_key UNIQUE (media_id, image_type, resolution);


--
-- Name: media_images media_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_images
    ADD CONSTRAINT media_images_pkey PRIMARY KEY (id);


--
-- Name: media media_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media
    ADD CONSTRAINT media_pkey PRIMARY KEY (id);


--
-- Name: media_relationships media_relationships_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_relationships
    ADD CONSTRAINT media_relationships_pkey PRIMARY KEY (id);


--
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


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
-- Name: videos videos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.videos
    ADD CONSTRAINT videos_pkey PRIMARY KEY (id);


--
-- Name: idx_credits_cast; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_credits_cast ON public.credits USING btree (media_id) WHERE (computed_is_cast = 1);


--
-- Name: idx_credits_director; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_credits_director ON public.credits USING btree (media_id) WHERE (computed_is_director = 1);


--
-- Name: idx_credits_media; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_credits_media ON public.credits USING btree (media_id, type, "order");


--
-- Name: idx_credits_person; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_credits_person ON public.credits USING btree (person_id, type);


--
-- Name: idx_external_data_data; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_external_data_data ON public.external_data USING gin (data);


--
-- Name: idx_external_data_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_external_data_type ON public.external_data USING btree (type);


--
-- Name: idx_external_data_updated_at_epoch; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_external_data_updated_at_epoch ON public.external_data USING btree (updated_at_epoch);


--
-- Name: idx_feed_session_mapping_feed_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_feed_session_mapping_feed_id ON public.feed_session_mapping USING btree (feed_id);


--
-- Name: idx_feed_session_mapping_session_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_feed_session_mapping_session_id ON public.feed_session_mapping USING btree (session_id);


--
-- Name: idx_media_images_lookup; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_media_images_lookup ON public.media_images USING btree (media_id, image_type, url);


--
-- Name: idx_media_is_adult; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_media_is_adult ON public.media USING btree (is_adult) WHERE (is_adult = false);


--
-- Name: idx_media_popularity; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_media_popularity ON public.media USING btree (popularity DESC);


--
-- Name: idx_media_relationships_from; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_media_relationships_from ON public.media_relationships USING btree ("from", type, "order");


--
-- Name: idx_media_relationships_to; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_media_relationships_to ON public.media_relationships USING btree ("to", type, "order");


--
-- Name: idx_people_popularity; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_people_popularity ON public.people USING btree (popularity DESC);


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
-- Name: idx_videos_media; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_videos_media ON public.videos USING btree (media_id, type, "order");


--
-- Name: credits credits_media_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credits
    ADD CONSTRAINT credits_media_id_fkey FOREIGN KEY (media_id) REFERENCES public.media(id) ON DELETE CASCADE;


--
-- Name: credits credits_person_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credits
    ADD CONSTRAINT credits_person_id_fkey FOREIGN KEY (person_id) REFERENCES public.people(id) ON DELETE CASCADE;


--
-- Name: feed_session_mapping feed_session_mapping_feed_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feed_session_mapping
    ADD CONSTRAINT feed_session_mapping_feed_id_fkey FOREIGN KEY (feed_id) REFERENCES public.feed(id) ON DELETE CASCADE;


--
-- Name: media_genres media_genres_genre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_genres
    ADD CONSTRAINT media_genres_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genres(id) ON DELETE CASCADE;


--
-- Name: media_genres media_genres_media_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_genres
    ADD CONSTRAINT media_genres_media_id_fkey FOREIGN KEY (media_id) REFERENCES public.media(id) ON DELETE CASCADE;


--
-- Name: media_images media_images_media_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_images
    ADD CONSTRAINT media_images_media_id_fkey FOREIGN KEY (media_id) REFERENCES public.media(id) ON DELETE CASCADE;


--
-- Name: media_relationships media_relationships_from_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_relationships
    ADD CONSTRAINT media_relationships_from_fkey FOREIGN KEY ("from") REFERENCES public.media(id) ON DELETE CASCADE;


--
-- Name: media_relationships media_relationships_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.media_relationships
    ADD CONSTRAINT media_relationships_to_fkey FOREIGN KEY ("to") REFERENCES public.media(id) ON DELETE CASCADE;


--
-- Name: videos videos_media_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.videos
    ADD CONSTRAINT videos_media_id_fkey FOREIGN KEY (media_id) REFERENCES public.media(id) ON DELETE CASCADE;


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
    ('20250621052321');
