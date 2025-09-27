package workerDBMaintenance

import (
	"context"
	"database/sql"
	_ "embed"
	"log/slog"
	"movieFinder/app/workerDBMaintenance/dbMaintenance"
	"os"
	"strconv"
	"time"
)

type Worker struct {
	db            *sql.DB
	logger        *slog.Logger
	dbMaintenance dbMaintenance.DBMaintenance
	cancel        context.CancelFunc
}

func New(db *sql.DB, logger *slog.Logger) *Worker {
	return &Worker{
		db:            db,
		logger:        logger.WithGroup("workerDBMaintenance"),
		dbMaintenance: dbMaintenance.New(db, logger),
	}
}

func (w *Worker) Start(ctx context.Context) chan struct{} {
	ctx, w.cancel = context.WithCancel(ctx)
	done := make(chan struct{})
	logger := w.logger.WithGroup("workerDBMaintenance")

	if workerDisabled, _ := strconv.ParseBool(os.Getenv("DB_MAINTENANCE_WORKER_DISABLED")); workerDisabled {
		logger.Info("DBMaintenanceWorker is disabled")
		close(done)
		return done
	}

	go func() {
		defer close(done)
		logger.Info("Starting database maintenance worker")
		// Run once a day
		ticker := time.NewTicker(24 * time.Hour)
		defer ticker.Stop()

		for {
			select {
			case <-ticker.C:
				if err := w.dbMaintenance.VacuumAnalyze(); err != nil {
					logger.Error("Failed to run database maintenance", "error", err)
				}
				if err := w.dbMaintenance.ReindexConcurrently(); err != nil {
					logger.Error("Failed to run database reindexBin", "error", err)
				}
			case <-ctx.Done():
				logger.Info("Stopping database maintenance worker")
				return
			}
		}
	}()

	return done
}

func (w *Worker) Stop() {
	if w.cancel != nil {
		w.cancel()
	}
}
