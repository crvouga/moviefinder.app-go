package mediaDB

import (
	"database/sql"
	"log/slog"
	"movieFinder/app/entityDB"
	"movieFinder/lib/tmdbAPI"
)

type Worker struct {
	DB                      *sql.DB
	tmdbClient              *tmdbAPI.Client
	Logger                  *slog.Logger
	upsertEntity            *entityDB.UpsertEntity
	matViews                *MediaDbMatViews
	loaderTmdbDiscoverMovie *LoaderTmdbDiscoverMovie
	loaderTmdbConfiguration *LoaderTmdbConfiguration
	loaderTmdbGenresMovie   *LoaderTmdbGenresMovie
}

func NewWorker(db *sql.DB, client *tmdbAPI.Client, logger *slog.Logger) (*Worker, error) {
	upsertEntity, err := entityDB.NewUpsertEntity(db)
	if err != nil {
		return nil, err
	}

	matViews := NewMediaDbMatViews(db, logger)

	loaderTmdbDiscoverMovie := NewLoaderTmdbDiscoverMovie(logger, db, upsertEntity, client)
	loaderTmdbConfiguration := NewLoaderTmdbConfiguration(logger, db, upsertEntity, client)
	loaderTmdbGenresMovie := NewLoaderTmdbGenresMovie(logger, db, upsertEntity, client)

	return &Worker{
		DB:                      db,
		tmdbClient:              client,
		Logger:                  logger,
		upsertEntity:            upsertEntity,
		matViews:                matViews,
		loaderTmdbDiscoverMovie: loaderTmdbDiscoverMovie,
		loaderTmdbConfiguration: loaderTmdbConfiguration,
		loaderTmdbGenresMovie:   loaderTmdbGenresMovie,
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

	doneDiscoverMovie := w.WorkerTmdbDiscoverMovieLoader()
	doneRefreshMatViews := w.matViews.RefreshWorker()

	done := make(chan struct{})
	go func() {
		<-doneDiscoverMovie
		<-doneRefreshMatViews
		w.Logger.Info("media worker completed successfully")
		close(done)
	}()

	return done
}

func (w *Worker) WorkerTmdbDiscoverMovieLoader() chan struct{} {
	logger := w.Logger.WithGroup("workerDiscoverMovie")
	done := make(chan struct{})

	go func() {
		if _, err := w.loaderTmdbConfiguration.upsert(logger); err != nil {
			logger.Error("Failed to upsert configuration", "error", err)
			close(done)
			return
		}
		if _, err := w.loaderTmdbGenresMovie.upsert(logger); err != nil {
			logger.Error("Failed to upsert genres movie", "error", err)
			close(done)
			return
		}
		logger.Info("Starting TMDB Discover Movie worker")
		logger.Info("Processing pages", "maxPages", w.loaderTmdbDiscoverMovie.MaxPages)

		doneDiscoverMovie := w.loaderTmdbDiscoverMovie.Run()
		select {
		case <-doneDiscoverMovie:
			logger.Info("TMDB Discover Movie worker completed")
		case <-done:
			logger.Info("TMDB Discover Movie worker stopped")
		}
	}()

	return done
}
