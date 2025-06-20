package feedRepo

import (
	"database/sql"
	_ "embed"
	"log/slog"
	"movieFinder/app/feed"
)

//go:embed queryFeedBySessionID.sql
var queryFeedBySessionIDSQL string

func QueryFeedBySessionID(db *sql.DB, sessionID string, logger *slog.Logger) (*feed.Feed, error) {
	logger.Debug("querying feed by session ID", "sessionID", sessionID)

	row := db.QueryRow(queryFeedBySessionIDSQL, sessionID)

	var feedID string
	var currentFeedIndex, createdAt, updatedAt int64

	err := row.Scan(&feedID, &currentFeedIndex, &createdAt, &updatedAt)

	if err != nil {
		logger.Debug("error querying feed", "error", err)
		return nil, err
	}

	feed_ := feed.Feed{
		ID:               feedID,
		CurrentFeedIndex: currentFeedIndex,
		CreatedAtEpoch:   createdAt,
		UpdatedAtEpoch:   updatedAt,
	}

	logger.Debug("successfully queried feed",
		"feedID", feed_.ID,
		"currentFeedIndex", feed_.CurrentFeedIndex,
		"createdAt", createdAt,
		"updatedAt", updatedAt)

	return &feed_, nil
}
