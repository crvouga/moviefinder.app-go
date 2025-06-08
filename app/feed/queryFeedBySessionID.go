package feed

import (
	"database/sql"
	_ "embed"
)

//go:embed queryFeedBySessionID.sql
var queryFeedBySessionIDSQL string

func QueryFeedBySessionID(db *sql.DB, sessionID string) (feed Feed, err error) {
	row := db.QueryRow(queryFeedBySessionIDSQL, sessionID)
	var createdAt, updatedAt int64
	err = row.Scan(&feed.ID, &feed.CurrentFeedIndex, &createdAt, &updatedAt)
	if err != nil {
		return Feed{}, err
	}
	feed.CreatedAtEpoch = createdAt
	feed.UpdatedAtEpoch = updatedAt
	return feed, nil
}
