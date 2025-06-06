package app

import (
	"database/sql"
	"log/slog"
	"movieFinder/app/media/mediaDB"
	"movieFinder/lib/tmdbAPI"
)

type Worker struct {
	DB         *sql.DB
	TmdbClient *tmdbAPI.Client
	Logger     *slog.Logger
}

func (w *Worker) Run() chan struct{} {
	w.Logger.Debug("starting worker")

	mediaDbWorker := mediaDB.NewWorker(w.DB, w.TmdbClient, w.Logger)

	done := mediaDbWorker.Run()

	go func() {
		<-done
		w.Logger.Debug("worker completed")
	}()

	return done
}
