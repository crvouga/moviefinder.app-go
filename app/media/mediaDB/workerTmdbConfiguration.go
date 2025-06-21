package mediaDB

import (
	"log/slog"
	"movieFinder/lib/tmdbAPI"
)

func (w *Worker) getConfiguration(logger *slog.Logger) (*tmdbAPI.ConfigurationResponse, error) {
	configuration, err := w.tmdbClient.Configuration()
	if err != nil {
		return nil, err
	}

	logger.Debug("Got TMDB configuration", "baseURL", configuration.Images.SecureBaseURL)
	logger.Debug("Image sizes", "posterSizes", configuration.Images.PosterSizes, "backdropSizes", configuration.Images.BackdropSizes)

	return &configuration, nil
}

func (w *Worker) upsertConfiguration(logger *slog.Logger) (*tmdbAPI.ConfigurationResponse, error) {
	configuration, err := w.getConfiguration(logger)
	logger.Info("Got TMDB configuration", "baseURL", configuration)
	if err != nil {
		logger.Error("Failed to get configuration", "error", err)

		return nil, err
	}

	tx, err := w.beginTransaction()
	if err != nil {
		logger.Error("Failed to begin transaction", "error", err)

		return nil, err
	}

	err = w.upsertEntity.Execute(tx, "tmdb/configuration", "0", configuration)
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
