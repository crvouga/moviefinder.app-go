package mediaDB

import (
	"database/sql"
	"log/slog"
	"movieFinder/lib/tmdbAPI"
)

func Loader(db *sql.DB, client *tmdbAPI.Client, logger *slog.Logger) chan struct{} {
	logger.Info("starting media loader")

	done := LoaderTmdbAPIDiscoverMovie(db, client, 500, logger)

	logger.Info("media loader completed successfully")
	return done
}
