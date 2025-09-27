package appWorker

import (
	"database/sql"
	"log/slog"
	"movieFinder/app/entityDB"
	"movieFinder/app/media/workerLoadTMDB"
	"movieFinder/app/media/workerMediaDB"
	"movieFinder/app/workerDBMaintenance"
	"movieFinder/lib/tmdbAPI"
)

type Worker struct {
	db         *sql.DB
	tmdbClient *tmdbAPI.Client
	logger     *slog.Logger
}

func New(db *sql.DB, tmdbClient *tmdbAPI.Client, logger *slog.Logger) *Worker {
	return &Worker{
		db:         db,
		tmdbClient: tmdbClient,
		logger:     logger.WithGroup("worker"),
	}
}

func (w *Worker) Run() (chan struct{}, error) {
	w.logger.Info("starting worker")

	upsertEntity, err := entityDB.NewUpsertEntity(w.db)
	if err != nil {
		w.logger.Error("failed to create upsert entity", "error", err)
		return nil, err
	}

	workerMediaDB := workerMediaDB.New(w.db, w.logger)
	workerLoadTMDB := workerLoadTMDB.New(w.logger, w.db, upsertEntity, w.tmdbClient)
	workerDbMaintenance := workerDBMaintenance.New(w.db, w.logger)

	doneMediaDB := workerMediaDB.Start()
	doneLoadTMDB := workerLoadTMDB.Start()
	doneDBMaintenance := workerDbMaintenance.Start()

	done := make(chan struct{})
	go func() {
		<-doneMediaDB
		<-doneLoadTMDB
		<-doneDBMaintenance
		w.logger.Info("all workers completed")
		close(done)
	}()

	return done, nil
}
