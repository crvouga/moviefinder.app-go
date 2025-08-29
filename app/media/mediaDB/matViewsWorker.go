package mediaDB

import (
	"database/sql"
	_ "embed"
	"log/slog"
	"time"
)

type MatViewsWorker struct {
	db       *sql.DB
	logger   *slog.Logger
	matViews *MatViews
}

func newMatViewsWorker(db *sql.DB, logger *slog.Logger) *MatViewsWorker {
	return &MatViewsWorker{
		db:       db,
		logger:   logger.WithGroup("workerMatViews"),
		matViews: NewMatViews(db, logger),
	}
}

var DISABLED = true

func (w *MatViewsWorker) Start() chan struct{} {
	done := make(chan struct{})
	logger := w.logger.WithGroup("workerMatViews")

	if DISABLED {
		logger.Info("MatViewsWorker is disabled")
		close(done)
		return done
	}

	go func() {
		logger.Info("Starting materialized views refresh worker")
		ticker := time.NewTicker(10 * time.Second)
		defer ticker.Stop()

		for {
			select {
			case <-ticker.C:
				if err := w.matViews.Refresh(); err != nil {
					logger.Error("Failed to refresh materialized views", "error", err)
				}
			case <-done:
				logger.Info("Stopping materialized views refresh worker")
				return
			}
		}
	}()

	return done
}
