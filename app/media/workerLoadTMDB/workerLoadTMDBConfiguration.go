package workerLoadTMDB

import (
	"database/sql"
	"log/slog"
	"movieFinder/app/entityDB"
	"movieFinder/lib/tmdbAPI"
)

type workerLoadTMDBConfiguration struct {
	Logger       *slog.Logger
	DB           *sql.DB
	UpsertEntity *entityDB.UpsertEntity
	TmdbClient   *tmdbAPI.Client
}

func newWorkerLoadTMDBConfiguration(logger *slog.Logger, db *sql.DB, upsertEntity *entityDB.UpsertEntity, tmdbClient *tmdbAPI.Client) *workerLoadTMDBConfiguration {
	return &workerLoadTMDBConfiguration{Logger: logger.WithGroup("loaderTmdbConfiguration"), DB: db, UpsertEntity: upsertEntity, TmdbClient: tmdbClient}
}

func (l *workerLoadTMDBConfiguration) run() chan struct{} {
	done := make(chan struct{})
	go func() {
		configuration, err := l.get()
		if err != nil {
			l.Logger.Error("Failed to get configuration", "error", err)
			close(done)
			return
		}
		if err := l.upsert(configuration); err != nil {
			l.Logger.Error("Failed to upsert configuration", "error", err)
			close(done)
			return
		}
		close(done)
	}()
	return done
}

func (l *workerLoadTMDBConfiguration) get() (*tmdbAPI.ConfigurationResponse, error) {
	configuration, err := l.TmdbClient.Configuration()

	if err != nil {
		return nil, err
	}

	l.Logger.Debug("Got TMDB configuration", "baseURL", configuration.Images.SecureBaseURL)

	l.Logger.Debug("Image sizes", "posterSizes", configuration.Images.PosterSizes, "backdropSizes", configuration.Images.BackdropSizes)

	return &configuration, nil
}

func (l *workerLoadTMDBConfiguration) upsert(configuration *tmdbAPI.ConfigurationResponse) error {
	l.Logger.Debug("Got TMDB configuration", "baseURL", configuration)

	tx, err := l.DB.Begin()

	if err != nil {
		l.Logger.Error("Failed to begin transaction", "error", err)

		return err
	}

	err = l.UpsertEntity.Execute(tx, "tmdb/configuration", "0", configuration)

	l.Logger.Info("Executed upsert external data", "error", err)

	if err != nil {
		l.Logger.Error("Failed to execute upsert external data", "error", err)
		return err
	}

	if err := tx.Commit(); err != nil {
		l.Logger.Error("Failed to commit transaction", "error", err)
		return err
	}

	return nil
}
