package mediaDB

import (
	"database/sql"
	"log/slog"
	"movieFinder/app/entityDB"
	"movieFinder/lib/tmdbAPI"
)

type Worker struct {
	DB             *sql.DB
	tmdbClient     *tmdbAPI.Client
	Logger         *slog.Logger
	upsertEntity   *entityDB.UpsertEntity
	workerMatViews *WorkerMatViews
	loaderTmdb     *LoaderTmdb
}

func NewWorker(db *sql.DB, client *tmdbAPI.Client, logger *slog.Logger) (*Worker, error) {
	upsertEntity, err := entityDB.NewUpsertEntity(db)

	if err != nil {
		return nil, err
	}

	workerMatViews := NewWorkerMatViews(db, logger)

	loaderTmdb := NewLoaderTmdb(logger, db, upsertEntity, client)

	return &Worker{
		DB:             db,
		tmdbClient:     client,
		Logger:         logger,
		upsertEntity:   upsertEntity,
		workerMatViews: workerMatViews,
		loaderTmdb:     loaderTmdb,
	}, nil
}

func (w *Worker) Close() error {
	if w.upsertEntity != nil {
		return w.upsertEntity.Close()
	}
	return nil
}

func (w *Worker) Start() chan struct{} {
	w.Logger.Info("starting media worker")

	doneTmdb := w.loaderTmdb.Start()
	doneRefreshMatViews := w.workerMatViews.Start()

	done := make(chan struct{})

	go func() {
		<-doneTmdb
		<-doneRefreshMatViews
		w.Logger.Info("media worker completed successfully")
		close(done)
	}()

	return done
}
