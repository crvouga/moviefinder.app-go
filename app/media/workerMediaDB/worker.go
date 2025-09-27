package workerMediaDB

import (
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

func (w *WorkerMediaDB) Start() chan struct{} {
	w.logger.Info("starting media worker")
	doneRefreshMatViews := w.matViewsWorker.Start()

	done := make(chan struct{})

	matViews := NewMatViews(w.db, w.logger)
	err := matViews.Init()
	if err != nil {
		w.logger.Error("failed to init mat views", "err", err)
	}

	go func() {
		<-doneRefreshMatViews
		w.logger.Info("media worker completed successfully")
		close(done)
	}()

	return done
}
