package workerMediaDB

import (
	"database/sql"
	"log/slog"
	"movieFinder/lib/tmdbAPI"
)

type WorkerMediaDB struct {
	DB             *sql.DB
	tmdbClient     *tmdbAPI.Client
	Logger         *slog.Logger
	matViewsWorker *MatViewsWorker
}

func New(db *sql.DB, client *tmdbAPI.Client, logger *slog.Logger) WorkerMediaDB {
	matViewsWorker := NewMatViewsWorker(db, logger)
	return WorkerMediaDB{
		DB:             db,
		tmdbClient:     client,
		Logger:         logger,
		matViewsWorker: matViewsWorker,
	}
}

func (w *WorkerMediaDB) Close() error {
	return nil
}

func (w *WorkerMediaDB) Start() chan struct{} {
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

func InitMatViews(db *sql.DB, logger *slog.Logger) {
	matViews := NewMatViews(db, logger)
	err := matViews.Init()
	if err != nil {
		logger.Error("failed to init mat views", "err", err)
	}
}
