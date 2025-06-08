package feed

import (
	"database/sql"
	_ "embed"
	"time"
)

//go:embed queryFeedBySessionID.sql
var queryFeedBySessionIDSQL string

func GetElseInsertFeed(db *sql.DB, sessionID string) (feedID string, feedIndex int64, err error) {
	row := db.QueryRow(queryFeedBySessionIDSQL, sessionID)
	var createdAt, updatedAt int64
	err = row.Scan(&feedID, &feedIndex, &createdAt, &updatedAt)
	if err == sql.ErrNoRows {
		// Create new feed
		feedID = "feed_" + sessionID
		feedIndex = 0
		now := time.Now().Unix()

		_, err = db.Exec(`INSERT INTO feed (id, current_feed_index, created_at_epoch, updated_at_epoch) 
			VALUES (?, ?, ?, ?)`, feedID, feedIndex, now, now)
		if err != nil {
			return "", 0, err
		}

		_, err = db.Exec(`INSERT INTO feed_session_mapping (id, feed_id, session_id, created_at_epoch, updated_at_epoch)
			VALUES (?, ?, ?, ?, ?)`, "fsm_"+sessionID, feedID, sessionID, now, now)
		if err != nil {
			return "", 0, err
		}

		return feedID, feedIndex, nil
	}
	if err != nil {
		return "", 0, err
	}
	return feedID, feedIndex, nil
}
