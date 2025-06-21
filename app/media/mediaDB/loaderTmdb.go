package mediaDB

import (
	"database/sql"
	"log/slog"
	"movieFinder/app/entityDB"
	"movieFinder/lib/tmdbAPI"
)

type LoaderTmdb struct {
	Logger                  *slog.Logger
	DB                      *sql.DB
	UpsertEntity            *entityDB.UpsertEntity
	TmdbClient              *tmdbAPI.Client
	LoaderTmdbConfiguration *LoaderTmdbConfiguration
	LoaderTmdbGenresMovie   *LoaderTmdbGenresMovie
	LoaderTmdbDiscoverMovie *LoaderTmdbDiscoverMovie
}

func NewLoaderTmdb(logger *slog.Logger, db *sql.DB, upsertEntity *entityDB.UpsertEntity, tmdbClient *tmdbAPI.Client) *LoaderTmdb {
	logger = logger.WithGroup("loaderTmdb")
	loaderTmdbConfiguration := NewLoaderTmdbConfiguration(logger, db, upsertEntity, tmdbClient)
	loaderTmdbGenresMovie := NewLoaderTmdbGenresMovie(logger, db, upsertEntity, tmdbClient)
	loaderTmdbDiscoverMovie := NewLoaderTmdbDiscoverMovie(logger, db, upsertEntity, tmdbClient)
	return &LoaderTmdb{
		Logger:                  logger,
		DB:                      db,
		UpsertEntity:            upsertEntity,
		TmdbClient:              tmdbClient,
		LoaderTmdbConfiguration: loaderTmdbConfiguration,
		LoaderTmdbGenresMovie:   loaderTmdbGenresMovie,
		LoaderTmdbDiscoverMovie: loaderTmdbDiscoverMovie,
	}
}

func (l *LoaderTmdb) Start() chan struct{} {
	done := make(chan struct{})

	go func() {
		doneConfiguration := l.LoaderTmdbConfiguration.Run()
		doneGenresMovie := l.LoaderTmdbGenresMovie.Run()
		<-doneConfiguration
		<-doneGenresMovie
		doneDiscoverMovie := l.LoaderTmdbDiscoverMovie.Run()
		<-doneDiscoverMovie
		l.Logger.Info("TMDB loader completed successfully")
		close(done)
	}()

	return done
}
