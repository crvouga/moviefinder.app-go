package workerDBMaintenance

import (
	"database/sql"
	_ "embed"
	"log/slog"
	"os"
	"strconv"
	"time"
)

type Worker struct {
	db            *sql.DB
	logger        *slog.Logger
	dbMaintenance *DBMaintenance
}

func New(db *sql.DB, logger *slog.Logger) *Worker {
	return &Worker{
		db:            db,
		logger:        logger.WithGroup("workerDBMaintenance"),
		dbMaintenance: NewDBMaintenance(db, logger),
	}
}

func (w *Worker) Start() chan struct{} {
	done := make(chan struct{})
	logger := w.logger.WithGroup("workerDBMaintenance")

	if workerDisabled, _ := strconv.ParseBool(os.Getenv("DB_MAINTENANCE_WORKER_DISABLED")); workerDisabled {
		logger.Info("DBMaintenanceWorker is disabled")
		close(done)
		return done
	}

	go func() {
		logger.Info("Starting database maintenance worker")
		// Run once a day
		ticker := time.NewTicker(24 * time.Hour)
		defer ticker.Stop()

		for {
			select {
			case <-ticker.C:
				if err := w.dbMaintenance.vacuumAnalyze(); err != nil {
					logger.Error("Failed to run database maintenance", "error", err)
				}
				if err := w.dbMaintenance.reindexConcurrently(); err != nil {
					logger.Error("Failed to run database reindexBin", "error", err)
				}
			case <-done:
				logger.Info("Stopping database maintenance worker")
				return
			}
		}
	}()

	return done
}
