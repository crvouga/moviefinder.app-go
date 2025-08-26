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
	workerLoadTMDBConfiguration *WorkerLoadTMDBConfiguration
	workerLoadTMDBGenresMovie   *WorkerLoadTMDBGenresMovie
	workerLoadTMDBDiscoverMovie *WorkerLoadTMDBDiscoverMovie
}

func NewWorker(logger *slog.Logger, db *sql.DB, upsertEntity *entityDB.UpsertEntity, tmdbClient *tmdbAPI.Client) *WorkerLoadTMDB {
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

func (l *WorkerLoadTMDB) Start() chan struct{} {
	done := make(chan struct{})

	go func() {
		doneConfiguration := l.workerLoadTMDBConfiguration.Run()
		doneGenresMovie := l.workerLoadTMDBGenresMovie.Run()
		<-doneConfiguration
		<-doneGenresMovie
		doneDiscoverMovie := l.workerLoadTMDBDiscoverMovie.Run()
		<-doneDiscoverMovie
		l.logger.Info("TMDB loader completed successfully")
		close(done)
	}()

	return done
}
