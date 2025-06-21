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
    ('20250621073938');
