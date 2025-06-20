package feedRepo

import (
	"database/sql"
	"log/slog"
	"movieFinder/app/feed"
	"time"
)

// GetElseInsertBySessionID retrieves an existing feed for the session ID or creates a new one
func GetElseInsertBySessionID(db *sql.DB, sessionID string, logger *slog.Logger) (*feed.Feed, error) {
	logger.Debug("getting or creating feed for session", "sessionID", sessionID)

	// Try to get existing feed first
	feed_, err := QueryFeedBySessionID(db, sessionID, logger)

	if err != nil && err != sql.ErrNoRows {
		logger.Debug("error querying feed", "error", err)
		return nil, err
	}

	if err == nil {
		logger.Debug("found existing feed", "feedID", feed_.ID)
		return feed_, nil
	}

	logger.Debug("no existing feed found, creating new one", "sessionID", sessionID)

	// No existing feed found, create new one
	now := time.Now().Unix()
	feed_ = &feed.Feed{
		ID:               sessionID, // Using session ID as feed ID for simplicity
		CurrentFeedIndex: 0,
		CreatedAtEpoch:   now,
		UpdatedAtEpoch:   now,
	}

	// Insert new feed
	if err = UpsertFeed(db, *feed_); err != nil {
		logger.Debug("error upserting feed", "error", err)
		return nil, err
	}
	logger.Debug("inserted new feed", "feedID", feed_.ID)

	// Create mapping
	if err = UpsertFeedSessionMapping(db, feed_.ID, sessionID); err != nil {
		logger.Debug("error upserting feed session mapping", "error", err)
		return nil, err
	}
	logger.Debug("created feed session mapping", "feedID", feed_.ID, "sessionID", sessionID)

	return feed_, nil
}
