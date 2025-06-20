package feedRepo

import (
	"database/sql"
	_ "embed"
	"movieFinder/app/feed"
)

//go:embed upsertFeed.sql
var upsertFeedSQL string

func UpsertFeed(db *sql.DB, feed_ feed.Feed) error {
	_, err := db.Exec(upsertFeedSQL, feed_.ID, feed_.CurrentFeedIndex, feed_.CreatedAtEpoch, feed_.UpdatedAtEpoch)
	return err
}
