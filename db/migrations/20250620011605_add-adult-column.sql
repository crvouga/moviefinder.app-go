-- migrate:up

ALTER TABLE media ADD COLUMN is_adult BOOLEAN NOT NULL DEFAULT FALSE;
CREATE INDEX idx_media_is_adult ON media(is_adult) WHERE is_adult = FALSE;

-- migrate:down

DROP INDEX IF EXISTS idx_media_is_adult;
ALTER TABLE media DROP COLUMN is_adult;
