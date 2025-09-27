package workerLoadTMDBMovieDetails

import (
	"context"
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
	cancel       context.CancelFunc
}

func New(logger *slog.Logger, db *sql.DB, upsertEntity *entityDB.UpsertEntity, tmdbClient *tmdbAPI.Client) *Worker {
	return &Worker{
		logger:       logger.WithGroup("loaderTmdbMovieDetails"),
		db:           db,
		upsertEntity: upsertEntity,
		tmdbClient:   tmdbClient,
	}
}

func (self *Worker) Start(ctx context.Context) chan struct{} {
	ctx, self.cancel = context.WithCancel(ctx)
	done := make(chan struct{})

	close(done)
	return done
}

func (self *Worker) Stop() {
	if self.cancel != nil {
		self.cancel()
	}
}
