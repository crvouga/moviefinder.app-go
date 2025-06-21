package mediaDB

import (
	"log/slog"
	"movieFinder/lib/tmdbAPI"
	"strconv"
)

func (w *Worker) getGenresMovie(logger *slog.Logger) (*tmdbAPI.GenresMovieResponse, error) {
	genres, err := w.tmdbClient.GenresMovie()
	if err != nil {
		return nil, err
	}

	logger.Debug("Got TMDB movie genres", "count", len(genres.Genres))

	return &genres, nil
}

func (w *Worker) upsertGenresMovie(logger *slog.Logger) (*tmdbAPI.GenresMovieResponse, error) {
	genres, err := w.getGenresMovie(logger)
	logger.Info("Got TMDB movie genres", "count", len(genres.Genres))
	if err != nil {
		logger.Error("Failed to get movie genres", "error", err)
		return nil, err
	}

	tx, err := w.beginTransaction()
	if err != nil {
		logger.Error("Failed to begin transaction", "error", err)
		return nil, err
	}

	for _, genre := range genres.Genres {
		err = w.upsertEntity.Execute(tx, "tmdb/genres/movie", strconv.FormatInt(int64(genre.ID), 10), genre)
		logger.Info("Executed upsert movie genre", "error", err)
		if err != nil {
			logger.Error("Failed to execute upsert movie genre", "error", err)
			return nil, err
		}
	}

	if err := tx.Commit(); err != nil {
		logger.Error("Failed to commit transaction", "error", err)
		return nil, err
	}

	return genres, nil
}
