package workerLoadTMDBGenresMovie

import (
	"database/sql"
	"log/slog"
	"movieFinder/app/entityDB"
	"movieFinder/lib/tmdbAPI"
	"strconv"
)

type Worker struct {
	logger       *slog.Logger
	db           *sql.DB
	upsertEntity *entityDB.UpsertEntity
	tmdbClient   *tmdbAPI.Client
}

func New(logger *slog.Logger, db *sql.DB, upsertEntity *entityDB.UpsertEntity, tmdbClient *tmdbAPI.Client) *Worker {
	return &Worker{logger: logger.WithGroup("genresMovie"), db: db, upsertEntity: upsertEntity, tmdbClient: tmdbClient}
}

func (l *Worker) Start() chan struct{} {
	done := make(chan struct{})
	go func() {
		genres, err := l.get()
		if err != nil {
			l.logger.Error("Failed to get movie genres", "error", err)
			close(done)
			return
		}
		if err := l.upsert(genres); err != nil {
			l.logger.Error("Failed to upsert movie genres", "error", err)
			close(done)
			return
		}
		close(done)
	}()
	return done
}

func (l *Worker) get() (*tmdbAPI.GenresMovieResponse, error) {
	genres, err := l.tmdbClient.GenresMovie()
	if err != nil {
		return nil, err
	}

	l.logger.Debug("Got TMDB movie genres", "count", len(genres.Genres))

	return &genres, nil
}

func (l *Worker) upsert(genres *tmdbAPI.GenresMovieResponse) error {
	l.logger.Info("Got TMDB movie genres", "count", len(genres.Genres))

	tx, err := l.db.Begin()
	if err != nil {
		l.logger.Error("Failed to begin transaction", "error", err)
		return err
	}

	for _, genre := range genres.Genres {
		err = l.upsertEntity.Execute(tx, "tmdb/genres/movie", strconv.FormatInt(int64(genre.ID), 10), genre)
		l.logger.Debug("Executed upsert movie genre", "error", err)
		if err != nil {
			l.logger.Error("Failed to execute upsert movie genre", "error", err)
			return err
		}
	}

	l.logger.Info("Upserted movie genres", "count", len(genres.Genres))

	if err := tx.Commit(); err != nil {
		l.logger.Error("Failed to commit transaction", "error", err)
		return err
	}

	return nil
}
