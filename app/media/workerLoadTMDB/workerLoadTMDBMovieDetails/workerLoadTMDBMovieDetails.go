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

func (l *Worker) Start(ctx context.Context) chan struct{} {
	ctx, l.cancel = context.WithCancel(ctx)
	done := make(chan struct{})
	close(done)
	return done
}

func (l *Worker) Stop() {
	if l.cancel != nil {
		l.cancel()
	}
}
