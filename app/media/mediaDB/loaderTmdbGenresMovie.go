package mediaDB

import (
	"database/sql"
	"fmt"
	"log/slog"
	"movieFinder/app/entityDB"
	"movieFinder/lib/tmdbAPI"
	"strconv"
)

type LoaderTmdbGenresMovie struct {
	Logger       *slog.Logger
	DB           *sql.DB
	UpsertEntity *entityDB.UpsertEntity
	TmdbClient   *tmdbAPI.Client
}

func NewLoaderTmdbGenresMovie(logger *slog.Logger, db *sql.DB, upsertEntity *entityDB.UpsertEntity, tmdbClient *tmdbAPI.Client) *LoaderTmdbGenresMovie {
	return &LoaderTmdbGenresMovie{Logger: logger.WithGroup("loaderTmdbGenresMovie"), DB: db, UpsertEntity: upsertEntity, TmdbClient: tmdbClient}
}

func (l *LoaderTmdbGenresMovie) get(logger *slog.Logger) (*tmdbAPI.GenresMovieResponse, error) {
	genres, err := l.TmdbClient.GenresMovie()
	if err != nil {
		return nil, err
	}

	logger.Debug("Got TMDB movie genres", "count", len(genres.Genres))

	return &genres, nil
}

func (l *LoaderTmdbGenresMovie) upsert(logger *slog.Logger) (*tmdbAPI.GenresMovieResponse, error) {
	genres, err := l.get(logger)
	logger.Info("Got TMDB movie genres", "count", len(genres.Genres))
	if err != nil {
		logger.Error("Failed to get movie genres", "error", err)
		return nil, err
	}

	tx, err := l.beginTransaction()
	if err != nil {
		logger.Error("Failed to begin transaction", "error", err)
		return nil, err
	}

	for _, genre := range genres.Genres {
		err = l.UpsertEntity.Execute(tx, "tmdb/genres/movie", strconv.FormatInt(int64(genre.ID), 10), genre)
		logger.Debug("Executed upsert movie genre", "error", err)
		if err != nil {
			logger.Error("Failed to execute upsert movie genre", "error", err)
			return nil, err
		}
	}

	logger.Info("Upserted movie genres", "count", len(genres.Genres))

	if err := tx.Commit(); err != nil {
		logger.Error("Failed to commit transaction", "error", err)
		return nil, err
	}

	return genres, nil
}

func (l *LoaderTmdbGenresMovie) beginTransaction() (*sql.Tx, error) {
	tx, err := l.DB.Begin()
	if err != nil {
		return nil, fmt.Errorf("failed to begin transaction: %v", err)
	}
	l.Logger.Debug("Starting database transaction")
	return tx, nil
}

func (l *LoaderTmdbGenresMovie) Run() chan struct{} {
	done := make(chan struct{})
	go func() {
		l.upsert(l.Logger)
	}()
	return done
}
