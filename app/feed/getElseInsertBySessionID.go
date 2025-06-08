package feed

import (
	"database/sql"
	"time"
)

// GetElseInsertBySessionID retrieves an existing feed for the session ID or creates a new one
func GetElseInsertBySessionID(db *sql.DB, sessionID string) (*Feed, error) {
	// Try to get existing feed first
	feed, err := QueryFeedBySessionID(db, sessionID)
	if err != nil && err != sql.ErrNoRows {
		return nil, err
	}

	if err == nil {
		return &feed, nil
	}

	// No existing feed found, create new one
	now := time.Now().Unix()
	feed = Feed{
		ID:               sessionID, // Using session ID as feed ID for simplicity
		CurrentFeedIndex: 0,
		CreatedAtEpoch:   now,
		UpdatedAtEpoch:   now,
	}

	// Insert new feed
	if err = UpsertFeed(db, feed); err != nil {
		return nil, err
	}

	// Create mapping
	if err = UpsertFeedSessionMapping(db, feed.ID, sessionID); err != nil {
		return nil, err
	}

	return &feed, nil
}
