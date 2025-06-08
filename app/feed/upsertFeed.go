package feed

import (
	"database/sql"
	_ "embed"
)

//go:embed upsertFeed.sql
var upsertFeedSQL string

func UpsertFeed(db *sql.DB, feed Feed) error {
	_, err := db.Exec(upsertFeedSQL, feed.ID, feed.CurrentFeedIndex, feed.CreatedAtEpoch, feed.UpdatedAtEpoch)
	return err
}
