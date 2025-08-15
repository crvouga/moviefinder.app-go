package feedDB

import (
	"database/sql"
	_ "embed"
)

//go:embed upsertFeedSessionMapping.sql
var upsertFeedSessionMappingSQL string

func UpsertFeedSessionMapping(db *sql.DB, feedID string, sessionID string) error {
	id := feedID + sessionID
	_, err := db.Exec(upsertFeedSessionMappingSQL, id, feedID, sessionID)
	return err
}
