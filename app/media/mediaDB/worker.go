package mediaDB

import (
	"database/sql"
	"log/slog"
	"movieFinder/lib/tmdbAPI"
)

type Worker struct {
	DB                    *sql.DB
	Client                *tmdbAPI.Client
	Logger                *slog.Logger
	MaxPagesDiscoverMovie int
}

func NewWorker(db *sql.DB, client *tmdbAPI.Client, logger *slog.Logger) Worker {
	return Worker{
		DB:                    db,
		Client:                client,
		Logger:                logger,
		MaxPagesDiscoverMovie: 100,
	}
}

func (w *Worker) Run() chan struct{} {
	w.Logger.Info("starting media loader")

	workerDiscoverMovie := NewWorkerLoadTmdbDiscoverMovie(w.DB, w.Client, w.MaxPagesDiscoverMovie, w.Logger)

	done := workerDiscoverMovie.Run()

	w.Logger.Info("media loader completed successfully")

	return done
}
