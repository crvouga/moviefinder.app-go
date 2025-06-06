package mediaDB

import (
	"database/sql"
	"log/slog"
	"movieFinder/lib/tmdbAPI"
	"time"
)

type Worker struct {
	DB                    *sql.DB
	Client                *tmdbAPI.Client
	Logger                *slog.Logger
	DiscoverMovieMaxPages int
	DiscoverMovieThrottle time.Duration
}

func NewWorker(db *sql.DB, client *tmdbAPI.Client, logger *slog.Logger) Worker {
	return Worker{
		DB:                    db,
		Client:                client,
		Logger:                logger,
		DiscoverMovieMaxPages: 100,
		DiscoverMovieThrottle: 1 * time.Second,
	}
}

func (w *Worker) Run() chan struct{} {
	w.Logger.Info("starting media worker")

	done := w.RunDiscoverMovie()

	w.Logger.Info("media worker completed successfully")

	return done
}
