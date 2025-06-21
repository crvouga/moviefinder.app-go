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

func (w *Worker) Run() (chan struct{}, error) {
	w.Logger.Debug("starting worker")

	mediaDBWorker, err := mediaDB.NewWorker(w.DB, w.TmdbClient, w.Logger)
	if err != nil {
		return nil, err
	}

	done := mediaDBWorker.Start()

	go func() {
		<-done
		// Clean up prepared statements when done
		if closeErr := mediaDBWorker.Close(); closeErr != nil {
			w.Logger.Error("Failed to close mediaDB worker", "error", closeErr)
		}
		w.Logger.Debug("worker completed")
	}()

	return done, nil
}
