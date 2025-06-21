package mediaDB

import (
	"database/sql"
	"log/slog"
	"movieFinder/app/entityDB"
	"movieFinder/lib/tmdbAPI"
)

type LoaderTmdbMovieDetails struct {
	Logger       *slog.Logger
	DB           *sql.DB
	UpsertEntity *entityDB.UpsertEntity
	TmdbClient   *tmdbAPI.Client
}

func NewLoaderTmdbMovieDetails(logger *slog.Logger, db *sql.DB, upsertEntity *entityDB.UpsertEntity, tmdbClient *tmdbAPI.Client) *LoaderTmdbMovieDetails {
	return &LoaderTmdbMovieDetails{
		Logger:       logger.WithGroup("loaderTmdbMovieDetails"),
		DB:           db,
		UpsertEntity: upsertEntity,
		TmdbClient:   tmdbClient,
	}
}

func (l *LoaderTmdbMovieDetails) Run() chan struct{} {
	done := make(chan struct{})

	return done
}
