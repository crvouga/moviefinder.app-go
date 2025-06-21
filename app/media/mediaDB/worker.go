package mediaDB

import (
	"database/sql"
	"log/slog"
	"movieFinder/app/externalDataDB"
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
	upsertExternalData *externalDataDB.UpsertExternalData
	matViews           *MediaDbMatViews
}

func NewWorker(db *sql.DB, client *tmdbAPI.Client, logger *slog.Logger) (*Worker, error) {
	upsertExternalData, err := externalDataDB.NewUpsertExternalData(db)
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
		upsertExternalData:    upsertExternalData,
		matViews:              matViews,
	}, nil
}

func (w *Worker) Close() error {
	if w.upsertExternalData != nil {
		return w.upsertExternalData.Close()
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
