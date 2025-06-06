package mediaDB

import (
	"database/sql"
	"log"
	"log/slog"
	"movieFinder/lib/tmdbAPI"
)

func Loader(db *sql.DB, client *tmdbAPI.Client, maxPages int, done chan struct{}, logger *slog.Logger) error {
	logger.Info("starting media loader", "maxPages", maxPages)
	err := LoaderTmdbAPIDiscoverMovie(db, client, maxPages, done, logger)
	if err != nil {
		log.Printf("Error in media loader: %v", err)
		return err
	}
	logger.Info("media loader completed successfully")
	return nil
}
