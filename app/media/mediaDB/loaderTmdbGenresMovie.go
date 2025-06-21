package mediaDB

import (
	"database/sql"
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

func (l *LoaderTmdbGenresMovie) Run() chan struct{} {
	done := make(chan struct{})
	go func() {
		genres, err := l.get()
		if err != nil {
			l.Logger.Error("Failed to get movie genres", "error", err)
			close(done)
			return
		}
		if err := l.upsert(genres); err != nil {
			l.Logger.Error("Failed to upsert movie genres", "error", err)
			close(done)
			return
		}
		close(done)
	}()
	return done
}

func (l *LoaderTmdbGenresMovie) get() (*tmdbAPI.GenresMovieResponse, error) {
	genres, err := l.TmdbClient.GenresMovie()
	if err != nil {
		return nil, err
	}

	l.Logger.Debug("Got TMDB movie genres", "count", len(genres.Genres))

	return &genres, nil
}

func (l *LoaderTmdbGenresMovie) upsert(genres *tmdbAPI.GenresMovieResponse) error {
	l.Logger.Info("Got TMDB movie genres", "count", len(genres.Genres))

	tx, err := l.DB.Begin()
	if err != nil {
		l.Logger.Error("Failed to begin transaction", "error", err)
		return err
	}

	for _, genre := range genres.Genres {
		err = l.UpsertEntity.Execute(tx, "tmdb/genres/movie", strconv.FormatInt(int64(genre.ID), 10), genre)
		l.Logger.Debug("Executed upsert movie genre", "error", err)
		if err != nil {
			l.Logger.Error("Failed to execute upsert movie genre", "error", err)
			return err
		}
	}

	l.Logger.Info("Upserted movie genres", "count", len(genres.Genres))

	if err := tx.Commit(); err != nil {
		l.Logger.Error("Failed to commit transaction", "error", err)
		return err
	}

	return nil
}
