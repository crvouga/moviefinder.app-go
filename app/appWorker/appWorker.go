package appWorker

import (
	"context"
	"database/sql"
	"log/slog"
	"movieFinder/app/entityDB"
	"movieFinder/app/media/workerLoadTMDB"
	"movieFinder/app/media/workerMediaDB"
	"movieFinder/app/workerDBMaintenance"
	"movieFinder/lib/tmdbAPI"
	"sync"
)

type Worker struct {
	db                  *sql.DB
	tmdbClient          *tmdbAPI.Client
	logger              *slog.Logger
	workerMediaDB       workerMediaDB.WorkerMediaDB
	workerLoadTMDB      *workerLoadTMDB.Worker
	workerDbMaintenance *workerDBMaintenance.Worker
}

func New(db *sql.DB, tmdbClient *tmdbAPI.Client, logger *slog.Logger) *Worker {
	return &Worker{
		db:         db,
		tmdbClient: tmdbClient,
		logger:     logger.WithGroup("worker"),
	}
}

func (w *Worker) Run(ctx context.Context) (chan struct{}, error) {
	w.logger.Info("starting worker")

	upsertEntity, err := entityDB.NewUpsertEntity(w.db)
	if err != nil {
		w.logger.Error("failed to create upsert entity", "error", err)
		return nil, err
	}

	w.workerMediaDB = workerMediaDB.New(w.db, w.logger)
	w.workerLoadTMDB = workerLoadTMDB.New(w.logger, w.db, upsertEntity, w.tmdbClient)
	w.workerDbMaintenance = workerDBMaintenance.New(w.db, w.logger)

	done := make(chan struct{})
	go func() {
		defer close(done)
		var wg sync.WaitGroup

		startWorker := func(start func(ctx context.Context) chan struct{}) {
			wg.Add(1)
			go func() {
				defer wg.Done()
				doneWorker := start(ctx)
				select {
				case <-doneWorker:
				case <-ctx.Done():
				}
			}()
		}

		startWorker(w.workerMediaDB.Start)
		startWorker(w.workerLoadTMDB.Start)
		startWorker(w.workerDbMaintenance.Start)

		waitDone := make(chan struct{})
		go func() {
			wg.Wait()
			close(waitDone)
		}()

		select {
		case <-waitDone:
			w.logger.Info("all workers completed")
		case <-ctx.Done():
			w.logger.Info("workers cancelled")
		}
	}()

	return done, nil
}

func (w *Worker) Stop() {
	w.workerLoadTMDB.Stop()
	w.workerMediaDB.Stop()
	w.workerDbMaintenance.Stop()
}
