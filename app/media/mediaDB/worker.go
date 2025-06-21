package mediaDB

import (
	"database/sql"
	"log/slog"
	"movieFinder/app/entityDB"
	"movieFinder/lib/tmdbAPI"
	"time"
)

type Worker struct {
	DB                    *sql.DB
	tmdbClient            *tmdbAPI.Client
	Logger                *slog.Logger
	DiscoverMovieMaxPages int
	DiscoverMovieThrottle time.Duration
	//
	upsertEntity *entityDB.UpsertEntity
	matViews     *MediaDbMatViews
}

func NewWorker(db *sql.DB, client *tmdbAPI.Client, logger *slog.Logger) (*Worker, error) {
	upsertEntity, err := entityDB.NewUpsertEntity(db)
	if err != nil {
		return nil, err
	}

	matViews := NewMediaDbMatViews(db, logger)

	return &Worker{
		DB:                    db,
		tmdbClient:            client,
		Logger:                logger,
		DiscoverMovieMaxPages: 500,
		DiscoverMovieThrottle: 20 * time.Second,
		upsertEntity:          upsertEntity,
		matViews:              matViews,
	}, nil
}

func (w *Worker) Close() error {
	if w.upsertEntity != nil {
		return w.upsertEntity.Close()
	}
	return nil
}

func (w *Worker) Run() chan struct{} {
	w.Logger.Info("starting media worker")

	doneDiscoverMovie := w.WorkerDiscoverMovieLoader()

	done := make(chan struct{})
	go func() {
		<-doneDiscoverMovie

		w.Logger.Info("media worker completed successfully")
		close(done)
	}()

	return done
}
