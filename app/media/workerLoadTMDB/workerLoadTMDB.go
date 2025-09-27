package workerLoadTMDB

import (
	"database/sql"
	"log/slog"
	"movieFinder/app/entityDB"
	"movieFinder/lib/tmdbAPI"
)

type WorkerLoadTMDB struct {
	logger                      *slog.Logger
	db                          *sql.DB
	upsertEntity                *entityDB.UpsertEntity
	tmdbClient                  *tmdbAPI.Client
	workerLoadTMDBConfiguration *workerLoadTMDBConfiguration
	workerLoadTMDBGenresMovie   *workerLoadTMDBGenresMovie
	workerLoadTMDBDiscoverMovie *workerLoadTMDBDiscoverMovie
}

func New(logger *slog.Logger, db *sql.DB, upsertEntity *entityDB.UpsertEntity, tmdbClient *tmdbAPI.Client) *WorkerLoadTMDB {
	logger = logger.WithGroup("loaderTmdb")
	loaderTmdbConfiguration := newWorkerLoadTMDBConfiguration(logger, db, upsertEntity, tmdbClient)
	loaderTmdbGenresMovie := newWorkerLoadTMDBGenresMovie(logger, db, upsertEntity, tmdbClient)
	loaderTmdbDiscoverMovie := newWorkerLoadTMDBDiscoverMovie(logger, db, upsertEntity, tmdbClient)
	return &WorkerLoadTMDB{
		logger:                      logger,
		db:                          db,
		upsertEntity:                upsertEntity,
		tmdbClient:                  tmdbClient,
		workerLoadTMDBConfiguration: loaderTmdbConfiguration,
		workerLoadTMDBGenresMovie:   loaderTmdbGenresMovie,
		workerLoadTMDBDiscoverMovie: loaderTmdbDiscoverMovie,
	}
}

func (l *WorkerLoadTMDB) Run() chan struct{} {
	done := make(chan struct{})

	go func() {
		doneConfiguration := l.workerLoadTMDBConfiguration.run()
		doneGenresMovie := l.workerLoadTMDBGenresMovie.run()
		<-doneConfiguration
		<-doneGenresMovie
		doneDiscoverMovie := l.workerLoadTMDBDiscoverMovie.run()
		<-doneDiscoverMovie
		l.logger.Info("TMDB loader completed successfully")
		close(done)
	}()

	return done
}
