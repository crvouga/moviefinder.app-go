package workerLoadTMDB

import (
	"database/sql"
	"log/slog"
	"movieFinder/app/entityDB"
	"movieFinder/app/media/workerLoadTMDB/workerLoadTMDBConfiguration"
	"movieFinder/app/media/workerLoadTMDB/workerLoadTMDBDiscoverMovie"
	"movieFinder/app/media/workerLoadTMDB/workerLoadTMDBGenresMovie"
	"movieFinder/app/media/workerLoadTMDB/workerLoadTMDBMovieDetails"
	"movieFinder/lib/tmdbAPI"
)

type Worker struct {
	logger                      *slog.Logger
	workerLoadTMDBConfiguration *workerLoadTMDBConfiguration.Worker
	workerLoadTMDBGenresMovie   *workerLoadTMDBGenresMovie.Worker
	workerLoadTMDBMovieDetails  *workerLoadTMDBMovieDetails.Worker
	workerLoadTMDBDiscoverMovie *workerLoadTMDBDiscoverMovie.Worker
}

func New(logger *slog.Logger, db *sql.DB, upsertEntity *entityDB.UpsertEntity, tmdbClient *tmdbAPI.Client) *Worker {
	logger = logger.WithGroup("loaderTmdb")
	return &Worker{
		logger:                      logger,
		workerLoadTMDBConfiguration: workerLoadTMDBConfiguration.New(logger, db, upsertEntity, tmdbClient),
		workerLoadTMDBGenresMovie:   workerLoadTMDBGenresMovie.New(logger, db, upsertEntity, tmdbClient),
		workerLoadTMDBDiscoverMovie: workerLoadTMDBDiscoverMovie.New(logger, db, upsertEntity, tmdbClient),
		workerLoadTMDBMovieDetails:  workerLoadTMDBMovieDetails.New(logger, db, upsertEntity, tmdbClient),
	}
}

func (l *Worker) Start() chan struct{} {
	done := make(chan struct{})

	go func() {
		l.logger.Info("Starting TMDB data loading")

		doneConfiguration := l.workerLoadTMDBConfiguration.Start()
		doneGenresMovie := l.workerLoadTMDBGenresMovie.Start()
		doneMovieDetails := l.workerLoadTMDBMovieDetails.Start()
		doneDiscoverMovie := l.workerLoadTMDBDiscoverMovie.Start()

		<-doneConfiguration
		<-doneGenresMovie
		<-doneMovieDetails
		<-doneDiscoverMovie
		<-doneMovieDetails

		l.logger.Info("TMDB data loading completed")
		close(done)
	}()

	return done
}
