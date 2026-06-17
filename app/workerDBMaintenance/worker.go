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

// High-activity tables that need frequent maintenance (see dbMaintenance.HighActivityTables).
var highActivityTables = dbMaintenance.HighActivityTables

func parseDuration(envVar string, defaultDuration time.Duration) time.Duration {
	value := os.Getenv(envVar)
	if value == "" {
		return defaultDuration
	}
	duration, err := time.ParseDuration(value)
	if err != nil {
		return defaultDuration
	}
	return duration
}

func New(db *sql.DB, logger *slog.Logger) *Worker {
	return &Worker{
		db:            db,
		logger:        logger.WithGroup("workerDBMaintenance"),
		dbMaintenance: dbMaintenance.New(db, logger),
	}
}

func (w *Worker) logStorageStats() {
	dbSize, err := w.dbMaintenance.GetDatabaseSize()
	if err != nil {
		w.logger.Warn("Failed to get database size", "error", err)
	} else {
		w.logger.Info("Database storage stats", "database_size", dbSize)
	}

	tableStats, err := w.dbMaintenance.GetHighActivityTableStats()
	if err != nil {
		w.logger.Warn("Failed to get table stats", "error", err)
	} else {
		for _, stats := range tableStats {
			w.logger.Info("Table storage stats",
				"table", stats.TableName,
				"total_size", stats.TotalSize,
				"table_size", stats.TableSize,
				"index_size", stats.IndexSize,
				"dead_tuples", stats.DeadTuples,
				"live_tuples", stats.LiveTuples,
				"bloat_ratio", stats.BloatRatio,
			)
		}
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

	// Parse environment variables for intervals
	vacuumInterval := parseDuration("DB_MAINTENANCE_VACUUM_INTERVAL", 6*time.Hour)
	reindexInterval := parseDuration("DB_MAINTENANCE_REINDEX_INTERVAL", 168*time.Hour)        // 1 week
	fullVacuumInterval := parseDuration("DB_MAINTENANCE_FULL_VACUUM_INTERVAL", 168*time.Hour) // 1 week

	logger.Info("Starting database maintenance worker",
		"vacuum_interval", vacuumInterval,
		"reindex_interval", reindexInterval,
		"full_vacuum_interval", fullVacuumInterval,
	)

	// Log initial storage stats
	w.logStorageStats()

	go func() {
		defer close(done)

		// Frequent vacuum ticker (default: every 6 hours)
		vacuumTicker := time.NewTicker(vacuumInterval)
		defer vacuumTicker.Stop()

		// Daily full vacuum ticker (once per day)
		dailyVacuumTicker := time.NewTicker(24 * time.Hour)
		defer dailyVacuumTicker.Stop()

		// Weekly reindex ticker (default: once per week)
		reindexTicker := time.NewTicker(reindexInterval)
		defer reindexTicker.Stop()

		// Weekly full vacuum ticker (default: once per week)
		fullVacuumTicker := time.NewTicker(fullVacuumInterval)
		defer fullVacuumTicker.Stop()

		// Track last full vacuum time to stagger it from reindex
		lastFullVacuum := time.Now()

		for {
			select {
			case <-vacuumTicker.C:
				// Frequent vacuum on high-activity tables
				logger.Info("Running frequent vacuum on high-activity tables")
				w.logStorageStats()
				for _, tableName := range highActivityTables {
					if err := w.dbMaintenance.VacuumTable(tableName); err != nil {
						logger.Error("Failed to vacuum table", "table", tableName, "error", err)
					}
				}
				w.logStorageStats()

			case <-dailyVacuumTicker.C:
				// Daily vacuum on all tables
				logger.Info("Running daily vacuum on all tables")
				w.logStorageStats()
				if err := w.dbMaintenance.VacuumAnalyze(); err != nil {
					logger.Error("Failed to run daily vacuum", "error", err)
				}
				w.logStorageStats()

			case <-reindexTicker.C:
				// Weekly reindex
				logger.Info("Running weekly reindex")
				w.logStorageStats()
				if err := w.dbMaintenance.ReindexConcurrently(); err != nil {
					logger.Error("Failed to run reindex", "error", err)
				}
				w.logStorageStats()

			case <-fullVacuumTicker.C:
				// Weekly full vacuum on critical tables
				// Stagger from reindex by checking if enough time has passed
				if time.Since(lastFullVacuum) >= fullVacuumInterval/2 {
					logger.Info("Running weekly full vacuum on critical tables")
					w.logStorageStats()
					for _, tableName := range highActivityTables {
						if err := w.dbMaintenance.VacuumFull(tableName); err != nil {
							logger.Error("Failed to run full vacuum on table", "table", tableName, "error", err)
						}
					}
					lastFullVacuum = time.Now()
					w.logStorageStats()
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
