-- migrate:up

CREATE TABLE external_data (
    id text NOT NULL,
    type text NOT NULL,
    data jsonb NOT NULL,
    updated_at_epoch bigint NOT NULL,
    PRIMARY KEY (id, type)
);

CREATE INDEX idx_external_data_type ON external_data (type);
CREATE INDEX idx_external_data_updated_at_epoch ON external_data (updated_at_epoch);
CREATE INDEX idx_external_data_data ON external_data USING GIN (data);


-- migrate:down

DROP TABLE IF EXISTS external_data CASCADE;