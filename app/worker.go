package app

import (
	"database/sql"
	"log/slog"
	"movieFinder/app/media/mediaDB"
	"movieFinder/lib/tmdbAPI"
)

type Worker struct {
	DB     *sql.DB
	Client *tmdbAPI.Client
	Logger *slog.Logger
}

func (w *Worker) Run() chan struct{} {
	w.Logger.Debug("starting media loader")
	worker := mediaDB.NewWorker(w.DB, w.Client, w.Logger)
	done := worker.Run()
	go func() {
		<-done
		w.Logger.Debug("media loader completed")
	}()

	return done
}
