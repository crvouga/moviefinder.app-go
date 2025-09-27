package workerDBMaintenance

import (
	"database/sql"
	"fmt"
	"log/slog"
	"time"
)

type DBMaintenance struct {
	db     *sql.DB
	logger *slog.Logger
}

func NewDBMaintenance(db *sql.DB, logger *slog.Logger) *DBMaintenance {
	return &DBMaintenance{
		db:     db,
		logger: logger.WithGroup("dbMaintenance"),
	}
}

func (m *DBMaintenance) vacuumAnalyze() error {
	m.logger.Info("Running VACUUM ANALYZE")
	start := time.Now()
	_, err := m.db.Exec("VACUUM ANALYZE")
	duration := time.Since(start)
	if err != nil {
		m.logger.Error("Failed to run VACUUM ANALYZE", "error", err, "duration", fmt.Sprintf("%.2fs", duration.Seconds()))
		return err
	}
	m.logger.Info("Successfully ran VACUUM ANALYZE", "duration", fmt.Sprintf("%.2fs", duration.Seconds()))
	return nil
}

func (m *DBMaintenance) reindexConcurrently() error {
	m.logger.Info("Running REINDEX SCHEMA CONCURRENTLY public")
	start := time.Now()
	// NOTE: REINDEX SCHEMA CONCURRENTLY requires PostgreSQL 12+
	// It cannot be run inside a transaction
	_, err := m.db.Exec("REINDEX SCHEMA CONCURRENTLY public")
	duration := time.Since(start)
	if err != nil {
		m.logger.Error("Failed to run REINDEX SCHEMA CONCURRENTLY", "error", err, "duration", fmt.Sprintf("%.2fs", duration.Seconds()))
		return err
	}
	m.logger.Info("Successfully ran REINDEX SCHEMA CONCURRENTLY", "duration", fmt.Sprintf("%.2fs", duration.Seconds()))
	return nil
}
