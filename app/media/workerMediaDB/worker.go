package workerMediaDB

import (
	"context"
	"database/sql"
	"log/slog"
)

type WorkerMediaDB struct {
	db             *sql.DB
	logger         *slog.Logger
	matViewsWorker *MatViewsWorker
}

func New(db *sql.DB, logger *slog.Logger) WorkerMediaDB {
	matViewsWorker := NewMatViewsWorker(db, logger)

	return WorkerMediaDB{
		db:             db,
		logger:         logger,
		matViewsWorker: matViewsWorker,
	}
}

func (w *WorkerMediaDB) Start(ctx context.Context) chan struct{} {
	w.logger.Info("starting media worker")

	// MatViews are initialized before the server starts in main.go
	// We only need to start the refresh worker here

	doneRefreshMatViews := w.matViewsWorker.Start(ctx)

	done := make(chan struct{})

	go func() {
		defer close(done)
		select {
		case <-doneRefreshMatViews:
			w.logger.Info("media worker completed successfully")
		case <-ctx.Done():
			w.logger.Info("media worker cancelled")
		}
	}()

	return done
}

func (w *WorkerMediaDB) Stop() {
	w.matViewsWorker.Stop()
}
