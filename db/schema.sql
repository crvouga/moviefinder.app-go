-- moviefinder_app_go schema (reference dump; regenerate with `make db-dump`)

CREATE SCHEMA moviefinder_app_go;

CREATE TABLE moviefinder_app_go.user_sessions (
    user_session_id text NOT NULL,
    user_id text NOT NULL,
    session_id text NOT NULL,
    created_at_epoch bigint NOT NULL,
    ended_at_epoch bigint NOT NULL
);

CREATE TABLE moviefinder_app_go.user_accounts (
    user_id text NOT NULL,
    phone_number text NOT NULL,
    created_at_epoch bigint NOT NULL,
    last_updated_at_epoch bigint NOT NULL
);

CREATE TABLE moviefinder_app_go.feed (
    id text NOT NULL,
    current_feed_index bigint NOT NULL,
    created_at_epoch bigint NOT NULL,
    updated_at_epoch bigint NOT NULL
);

CREATE TABLE moviefinder_app_go.feed_session_mapping (
    id text NOT NULL,
    feed_id text NOT NULL,
    session_id text NOT NULL,
    created_at_epoch bigint NOT NULL,
    updated_at_epoch bigint NOT NULL
);

CREATE TABLE moviefinder_app_go.entities (
    id text NOT NULL,
    type text NOT NULL,
    data jsonb NOT NULL,
    updated_at_epoch bigint NOT NULL
);

CREATE TABLE moviefinder_app_go.schema_migrations (
    version character varying NOT NULL
);

ALTER TABLE ONLY moviefinder_app_go.user_sessions
    ADD CONSTRAINT user_sessions_pkey PRIMARY KEY (user_session_id);

ALTER TABLE ONLY moviefinder_app_go.user_accounts
    ADD CONSTRAINT user_accounts_pkey PRIMARY KEY (user_id);

ALTER TABLE ONLY moviefinder_app_go.feed
    ADD CONSTRAINT feed_pkey PRIMARY KEY (id);

ALTER TABLE ONLY moviefinder_app_go.feed_session_mapping
    ADD CONSTRAINT feed_session_mapping_pkey PRIMARY KEY (id);

ALTER TABLE ONLY moviefinder_app_go.entities
    ADD CONSTRAINT entities_pkey PRIMARY KEY (id, type);

ALTER TABLE ONLY moviefinder_app_go.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);

CREATE INDEX idx_user_sessions_session_id ON moviefinder_app_go.user_sessions USING btree (session_id);
CREATE INDEX idx_user_sessions_active ON moviefinder_app_go.user_sessions USING btree (session_id)
    WHERE (ended_at_epoch IS NOT NULL);
CREATE INDEX idx_user_accounts_phone_number ON moviefinder_app_go.user_accounts USING btree (phone_number);
CREATE INDEX idx_feed_session_mapping_feed_id ON moviefinder_app_go.feed_session_mapping USING btree (feed_id);
CREATE INDEX idx_feed_session_mapping_session_id ON moviefinder_app_go.feed_session_mapping USING btree (session_id);
CREATE INDEX idx_entities_type ON moviefinder_app_go.entities USING btree (type);
CREATE INDEX idx_entities_updated_at_epoch ON moviefinder_app_go.entities USING btree (updated_at_epoch);
CREATE INDEX idx_entities_data ON moviefinder_app_go.entities USING gin (data);

ALTER TABLE ONLY moviefinder_app_go.feed_session_mapping
    ADD CONSTRAINT feed_session_mapping_feed_id_fkey FOREIGN KEY (feed_id) REFERENCES moviefinder_app_go.feed (id) ON DELETE CASCADE;
