package mediaDB

import (
	"database/sql"
	"log/slog"
	"movieFinder/lib/tmdbAPI"
)

type Worker struct {
	DB             *sql.DB
	tmdbClient     *tmdbAPI.Client
	Logger         *slog.Logger
	matViewsWorker *MatViewsWorker
}

func NewWorker(db *sql.DB, client *tmdbAPI.Client, logger *slog.Logger) Worker {
	matViewsWorker := newMatViewsWorker(db, logger)
	return Worker{
		DB:             db,
		tmdbClient:     client,
		Logger:         logger,
		matViewsWorker: matViewsWorker,
	}
}

func (w *Worker) Close() error {
	return nil
}

func (w *Worker) Start() chan struct{} {
	w.Logger.Info("starting media worker")
	doneRefreshMatViews := w.matViewsWorker.Start()

	done := make(chan struct{})

	go func() {
		<-doneRefreshMatViews
		w.Logger.Info("media worker completed successfully")
		close(done)
	}()

	return done
}
