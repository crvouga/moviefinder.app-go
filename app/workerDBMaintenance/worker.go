package workerDBMaintenance

import (
	"database/sql"
	_ "embed"
	"log/slog"
	"os"
	"strconv"
	"time"
)

type DBMaintenanceWorker struct {
	db            *sql.DB
	logger        *slog.Logger
	dbMaintenance *DBMaintenance
}

func NewDBMaintenanceWorker(db *sql.DB, logger *slog.Logger) *DBMaintenanceWorker {
	return &DBMaintenanceWorker{
		db:            db,
		logger:        logger.WithGroup("workerDBMaintenance"),
		dbMaintenance: NewDBMaintenance(db, logger),
	}
}

var DISABLED = true

func (w *DBMaintenanceWorker) Start() chan struct{} {
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
			case <-done:
				logger.Info("Stopping database maintenance worker")
				return
			}
		}
	}()

	return done
}
