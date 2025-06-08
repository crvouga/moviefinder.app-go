package feed

import (
	"database/sql"
	"time"
)

// CreateFeed creates a new feed record with default values
func CreateFeed(db *sql.DB) (string, error) {
	feedID := "feed_" + time.Now().Format("20060102150405")
	now := time.Now().Unix()

	_, err := db.Exec(`
		INSERT INTO feed (
			id,
			current_feed_index,
			created_at_epoch,
			updated_at_epoch
		) VALUES (?, ?, ?, ?)`,
		feedID,
		0, // Start at index 0
		now,
		now,
	)

	if err != nil {
		return "", err
	}

	return feedID, nil
}
