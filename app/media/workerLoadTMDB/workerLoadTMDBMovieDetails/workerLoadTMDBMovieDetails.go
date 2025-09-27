package workerLoadTMDBMovieDetails

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
	return &Worker{
		logger:       logger.WithGroup("loaderTmdbMovieDetails"),
		db:           db,
		upsertEntity: upsertEntity,
		tmdbClient:   tmdbClient,
	}
}

func (l *Worker) Start() chan struct{} {
	done := make(chan struct{})

	return done
}
