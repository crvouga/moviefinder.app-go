-- migrate:up

-- Rename the table
ALTER TABLE external_data RENAME TO entities;

-- Rename the primary key constraint
ALTER TABLE entities RENAME CONSTRAINT external_data_pkey TO entities_pkey;

-- Rename the indexes
ALTER INDEX idx_external_data_data RENAME TO idx_entities_data;
ALTER INDEX idx_external_data_type RENAME TO idx_entities_type;
ALTER INDEX idx_external_data_updated_at_epoch RENAME TO idx_entities_updated_at_epoch;

-- migrate:down

-- Rename the indexes back
ALTER INDEX idx_entities_data RENAME TO idx_external_data_data;
ALTER INDEX idx_entities_type RENAME TO idx_external_data_type;
ALTER INDEX idx_entities_updated_at_epoch RENAME TO idx_external_data_updated_at_epoch;

-- Rename the primary key constraint back
ALTER TABLE entities RENAME CONSTRAINT entities_pkey TO external_data_pkey;

-- Rename the table back
ALTER TABLE entities RENAME TO external_data;

