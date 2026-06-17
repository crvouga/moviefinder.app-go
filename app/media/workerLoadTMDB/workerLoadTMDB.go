package workerLoadTMDB

import (
	"context"
	"database/sql"
	"log/slog"
	"movieFinder/app/entityDB"
	"movieFinder/app/media/workerLoadTMDB/workerLoadTMDBConfiguration"
	"movieFinder/app/media/workerLoadTMDB/workerLoadTMDBDiscoverMovie"
	"movieFinder/app/media/workerLoadTMDB/workerLoadTMDBGenresMovie"
	"movieFinder/app/media/workerLoadTMDB/workerLoadTMDBMovieDetails"
	"movieFinder/lib/tmdbAPI"
	"sync"
	"time"
)

type Worker struct {
	logger                      *slog.Logger
	db                          *sql.DB
	workerLoadTMDBConfiguration *workerLoadTMDBConfiguration.Worker
	workerLoadTMDBGenresMovie   *workerLoadTMDBGenresMovie.Worker
	workerLoadTMDBMovieDetails  *workerLoadTMDBMovieDetails.Worker
	workerLoadTMDBDiscoverMovie *workerLoadTMDBDiscoverMovie.Worker
	cancel                      context.CancelFunc
}

func New(logger *slog.Logger, db *sql.DB, upsertEntity *entityDB.UpsertEntity, tmdbClient *tmdbAPI.Client) *Worker {
	logger = logger.WithGroup("loaderTmdb")
	return &Worker{
		logger:                      logger,
		db:                          db,
		workerLoadTMDBConfiguration: workerLoadTMDBConfiguration.New(logger, db, upsertEntity, tmdbClient),
		workerLoadTMDBGenresMovie:   workerLoadTMDBGenresMovie.New(logger, db, upsertEntity, tmdbClient),
		workerLoadTMDBDiscoverMovie: workerLoadTMDBDiscoverMovie.New(logger, db, upsertEntity, tmdbClient),
		workerLoadTMDBMovieDetails:  workerLoadTMDBMovieDetails.New(logger, db, upsertEntity, tmdbClient),
	}
}

func (l *Worker) waitForMediaView(ctx context.Context) error {
	for {
		select {
		case <-ctx.Done():
			return ctx.Err()
		default:
			var exists bool
			err := l.db.QueryRowContext(ctx, `
				SELECT EXISTS (
					SELECT 1 
					FROM information_schema.views 
					WHERE table_schema = 'moviefinder_app_go'
					  AND table_name = 'media_denormalized_v'
				)
			`).Scan(&exists)

			if err != nil {
				l.logger.Error("Error checking for media_denormalized_v view", "error", err)
				return err
			}

			if exists {
				l.logger.Info("media_denormalized_v view is ready")
				return nil
			}

			l.logger.Info("Waiting for media_denormalized_v view to be created...")
			time.Sleep(5 * time.Second)
		}
	}
}

func (l *Worker) Start(ctx context.Context) chan struct{} {
	ctx, l.cancel = context.WithCancel(ctx)
	done := make(chan struct{})

	go func() {
		defer close(done)
		l.logger.Info("Starting TMDB data loading")

		if err := l.waitForMediaView(ctx); err != nil {
			l.logger.Error("Failed waiting for media view", "error", err)
			return
		}

		var wg sync.WaitGroup

		startWorker := func(start func(ctx context.Context) chan struct{}) {
			wg.Add(1)
			go func() {
				defer wg.Done()
				doneWorker := start(ctx)
				select {
				case <-doneWorker:
				case <-ctx.Done():
				}
			}()
		}

		startWorker(l.workerLoadTMDBConfiguration.Start)
		startWorker(l.workerLoadTMDBGenresMovie.Start)
		startWorker(l.workerLoadTMDBMovieDetails.Start)
		startWorker(l.workerLoadTMDBDiscoverMovie.Start)

		waitDone := make(chan struct{})
		go func() {
			wg.Wait()
			close(waitDone)
		}()

		select {
		case <-waitDone:
			l.logger.Info("TMDB data loading completed")
		case <-ctx.Done():
			l.logger.Info("TMDB data loading cancelled")
		}

	}()

	return done
}

func (l *Worker) Stop() {
	if l.cancel != nil {
		l.cancel()
	}
}
