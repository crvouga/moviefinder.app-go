package app

import (
	"database/sql"
	"log/slog"
	"movieFinder/app/entityDB"
	"movieFinder/app/media/mediaDB"
	"movieFinder/app/media/workerLoadTMDB"
	"movieFinder/lib/tmdbAPI"
)

type Worker struct {
	db         *sql.DB
	tmdbClient *tmdbAPI.Client
	logger     *slog.Logger
}

func NewWorker(db *sql.DB, tmdbClient *tmdbAPI.Client, logger *slog.Logger) *Worker {
	return &Worker{
		db:         db,
		tmdbClient: tmdbClient,
		logger:     logger,
	}
}

func (w *Worker) Run() (chan struct{}, error) {
	w.logger.Info("starting worker")

	w.logger.Debug("creating upsert entity")
	upsertEntity, err := entityDB.NewUpsertEntity(w.db)
	if err != nil {
		w.logger.Error("failed to create upsert entity", "error", err)
		return nil, err
	}

	w.logger.Debug("creating workers")
	workerMediaDB := mediaDB.NewWorker(w.db, w.tmdbClient, w.logger)
	workerLoadTMDB := workerLoadTMDB.NewWorker(w.logger, w.db, upsertEntity, w.tmdbClient)

	w.logger.Debug("starting workers")
	doneMediaDB := workerMediaDB.Start()
	doneLoadTMDB := workerLoadTMDB.Start()
	done := make(chan struct{})

	go func() {
		w.logger.Debug("waiting for workers to complete")
		<-doneMediaDB
		w.logger.Debug("mediaDB worker completed")
		<-doneLoadTMDB
		w.logger.Debug("loadTMDB worker completed")

		w.logger.Debug("closing mediaDB worker")
		if closeErr := workerMediaDB.Close(); closeErr != nil {
			w.logger.Error("Failed to close mediaDB worker", "error", closeErr)
		}
		w.logger.Info("worker completed successfully")
		close(done)
	}()

	return done, nil
}
