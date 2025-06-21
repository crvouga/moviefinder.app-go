package mediaDB

import (
	"database/sql"
	"fmt"
	"log/slog"
	"movieFinder/app/entityDB"
	"movieFinder/lib/tmdbAPI"
)

type LoaderTmdbConfiguration struct {
	Logger       *slog.Logger
	DB           *sql.DB
	UpsertEntity *entityDB.UpsertEntity
	TmdbClient   *tmdbAPI.Client
}

func NewLoaderTmdbConfiguration(logger *slog.Logger, db *sql.DB, upsertEntity *entityDB.UpsertEntity, tmdbClient *tmdbAPI.Client) *LoaderTmdbConfiguration {
	return &LoaderTmdbConfiguration{Logger: logger.WithGroup("loaderTmdbConfiguration"), DB: db, UpsertEntity: upsertEntity, TmdbClient: tmdbClient}
}

func (l *LoaderTmdbConfiguration) get(logger *slog.Logger) (*tmdbAPI.ConfigurationResponse, error) {
	configuration, err := l.TmdbClient.Configuration()
	if err != nil {
		return nil, err
	}

	logger.Debug("Got TMDB configuration", "baseURL", configuration.Images.SecureBaseURL)
	logger.Debug("Image sizes", "posterSizes", configuration.Images.PosterSizes, "backdropSizes", configuration.Images.BackdropSizes)

	return &configuration, nil
}

func (l *LoaderTmdbConfiguration) upsert(logger *slog.Logger) (*tmdbAPI.ConfigurationResponse, error) {
	configuration, err := l.get(logger)
	logger.Debug("Got TMDB configuration", "baseURL", configuration)
	if err != nil {
		logger.Error("Failed to get configuration", "error", err)

		return nil, err
	}

	tx, err := l.beginTransaction()
	if err != nil {
		logger.Error("Failed to begin transaction", "error", err)

		return nil, err
	}

	err = l.UpsertEntity.Execute(tx, "tmdb/configuration", "0", configuration)
	logger.Info("Executed upsert external data", "error", err)
	if err != nil {
		logger.Error("Failed to execute upsert external data", "error", err)

		return nil, err
	}

	if err := tx.Commit(); err != nil {
		logger.Error("Failed to commit transaction", "error", err)
		return nil, err
	}

	return configuration, nil
}

func (l *LoaderTmdbConfiguration) beginTransaction() (*sql.Tx, error) {
	tx, err := l.DB.Begin()
	if err != nil {
		return nil, fmt.Errorf("failed to begin transaction: %v", err)
	}
	l.Logger.Debug("Starting database transaction")
	return tx, nil
}

func (l *LoaderTmdbConfiguration) Run() chan struct{} {
	done := make(chan struct{})
	go func() {
		l.upsert(l.Logger)
	}()
	return done
}
