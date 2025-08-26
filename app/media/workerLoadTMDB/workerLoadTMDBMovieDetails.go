package workerLoadTMDB

import (
	"database/sql"
	"log/slog"
	"movieFinder/app/entityDB"
	"movieFinder/lib/tmdbAPI"
)

type WorkerLoadTMDBMovieDetails struct {
	Logger       *slog.Logger
	DB           *sql.DB
	UpsertEntity *entityDB.UpsertEntity
	TmdbClient   *tmdbAPI.Client
}

func NewWorkerLoadTMDBMovieDetails(logger *slog.Logger, db *sql.DB, upsertEntity *entityDB.UpsertEntity, tmdbClient *tmdbAPI.Client) *WorkerLoadTMDBMovieDetails {
	return &WorkerLoadTMDBMovieDetails{
		Logger:       logger.WithGroup("loaderTmdbMovieDetails"),
		DB:           db,
		UpsertEntity: upsertEntity,
		TmdbClient:   tmdbClient,
	}
}

func (l *WorkerLoadTMDBMovieDetails) Run() chan struct{} {
	done := make(chan struct{})

	return done
}
