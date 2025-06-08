package feed

import (
	"database/sql"
	_ "embed"
	"log/slog"
)

//go:embed queryFeedBySessionID.sql
var queryFeedBySessionIDSQL string

func QueryFeedBySessionID(db *sql.DB, sessionID string, logger *slog.Logger) (feed Feed, err error) {
	logger.Debug("querying feed by session ID", "sessionID", sessionID)

	row := db.QueryRow(queryFeedBySessionIDSQL, sessionID)
	var createdAt, updatedAt int64
	err = row.Scan(&feed.ID, &feed.CurrentFeedIndex, &createdAt, &updatedAt)
	if err != nil {
		logger.Debug("error querying feed", "error", err)
		return Feed{}, err
	}

	feed.CreatedAtEpoch = createdAt
	feed.UpdatedAtEpoch = updatedAt

	logger.Debug("successfully queried feed",
		"feedID", feed.ID,
		"currentFeedIndex", feed.CurrentFeedIndex,
		"createdAt", createdAt,
		"updatedAt", updatedAt)

	return feed, nil
}
