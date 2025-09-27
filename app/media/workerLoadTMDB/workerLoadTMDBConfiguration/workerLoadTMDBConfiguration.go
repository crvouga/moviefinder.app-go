package workerLoadTMDBConfiguration

import (
	"database/sql"
	"log/slog"
	"movieFinder/app/entityDB"
	"movieFinder/lib/tmdbAPI"
)

type Worker struct {
	logger       *slog.Logger
	db           *sql.DB
	upsertEntity *entityDB.UpsertEntity
	tmdbClient   *tmdbAPI.Client
}

func New(logger *slog.Logger, db *sql.DB, upsertEntity *entityDB.UpsertEntity, tmdbClient *tmdbAPI.Client) *Worker {
	return &Worker{logger: logger.WithGroup("configuration"), db: db, upsertEntity: upsertEntity, tmdbClient: tmdbClient}
}

func (l *Worker) Start() chan struct{} {
	done := make(chan struct{})
	go func() {
		configuration, err := l.get()
		if err != nil {
			l.logger.Error("Failed to get configuration", "error", err)
			close(done)
			return
		}
		if err := l.upsert(configuration); err != nil {
			l.logger.Error("Failed to upsert configuration", "error", err)
			close(done)
			return
		}
		close(done)
	}()
	return done
}

func (l *Worker) get() (*tmdbAPI.ConfigurationResponse, error) {
	configuration, err := l.tmdbClient.Configuration()

	if err != nil {
		return nil, err
	}

	l.logger.Debug("Got TMDB configuration", "baseURL", configuration.Images.SecureBaseURL)

	l.logger.Debug("Image sizes", "posterSizes", configuration.Images.PosterSizes, "backdropSizes", configuration.Images.BackdropSizes)

	return &configuration, nil
}

func (l *Worker) upsert(configuration *tmdbAPI.ConfigurationResponse) error {
	l.logger.Debug("Got TMDB configuration", "baseURL", configuration)

	tx, err := l.db.Begin()

	if err != nil {
		l.logger.Error("Failed to begin transaction", "error", err)

		return err
	}

	err = l.upsertEntity.Execute(tx, "tmdb/configuration", "0", configuration)

	l.logger.Info("Executed upsert external data", "error", err)

	if err != nil {
		l.logger.Error("Failed to execute upsert external data", "error", err)
		return err
	}

	if err := tx.Commit(); err != nil {
		l.logger.Error("Failed to commit transaction", "error", err)
		return err
	}

	return nil
}
