package dbMaintenance

import (
	"database/sql"
	"log/slog"
	"time"
)

type DBMaintenance struct {
	db     *sql.DB
	logger *slog.Logger
}

func New(db *sql.DB, logger *slog.Logger) DBMaintenance {
	return DBMaintenance{
		db:     db,
		logger: logger.WithGroup("dbMaintenance"),
	}
}

func (m *DBMaintenance) VacuumAnalyze() error {
	start := time.Now()
	if _, err := m.db.Exec("VACUUM ANALYZE"); err != nil {
		m.logger.Error("VACUUM ANALYZE failed", "error", err, "duration", time.Since(start))
		return err
	}
	m.logger.Info("VACUUM ANALYZE completed", "duration", time.Since(start))
	return nil
}

func (m *DBMaintenance) ReindexConcurrently() error {
	start := time.Now()
	if _, err := m.db.Exec("REINDEX SCHEMA CONCURRENTLY public"); err != nil {
		m.logger.Error("REINDEX failed", "error", err, "duration", time.Since(start))
		return err
	}
	m.logger.Info("REINDEX completed", "duration", time.Since(start))
	return nil
}
