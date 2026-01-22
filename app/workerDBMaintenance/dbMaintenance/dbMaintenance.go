package dbMaintenance

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

type TableStats struct {
	TableName      string
	TableSize      string
	IndexSize      string
	TotalSize      string
	DeadTuples     int64
	LiveTuples     int64
	BloatRatio     float64
	LastVacuum     *time.Time
	LastAutoVacuum *time.Time
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

func (m *DBMaintenance) VacuumTable(tableName string) error {
	start := time.Now()
	query := fmt.Sprintf("VACUUM ANALYZE %s", tableName)
	if _, err := m.db.Exec(query); err != nil {
		m.logger.Error("VACUUM ANALYZE table failed", "table", tableName, "error", err, "duration", time.Since(start))
		return err
	}
	m.logger.Info("VACUUM ANALYZE table completed", "table", tableName, "duration", time.Since(start))
	return nil
}

func (m *DBMaintenance) VacuumFull(tableName string) error {
	start := time.Now()
	query := fmt.Sprintf("VACUUM FULL ANALYZE %s", tableName)
	if _, err := m.db.Exec(query); err != nil {
		m.logger.Error("VACUUM FULL ANALYZE table failed", "table", tableName, "error", err, "duration", time.Since(start))
		return err
	}
	m.logger.Info("VACUUM FULL ANALYZE table completed", "table", tableName, "duration", time.Since(start))
	return nil
}

func (m *DBMaintenance) AnalyzeTable(tableName string) error {
	start := time.Now()
	query := fmt.Sprintf("ANALYZE %s", tableName)
	if _, err := m.db.Exec(query); err != nil {
		m.logger.Error("ANALYZE table failed", "table", tableName, "error", err, "duration", time.Since(start))
		return err
	}
	m.logger.Info("ANALYZE table completed", "table", tableName, "duration", time.Since(start))
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

func (m *DBMaintenance) GetDatabaseSize() (string, error) {
	var size string
	err := m.db.QueryRow("SELECT pg_size_pretty(pg_database_size(current_database()))").Scan(&size)
	if err != nil {
		m.logger.Error("Failed to get database size", "error", err)
		return "", err
	}
	return size, nil
}

func (m *DBMaintenance) GetTableStats(tableName string) (*TableStats, error) {
	query := `
		SELECT 
			schemaname || '.' || tablename as table_name,
			pg_size_pretty(pg_total_relation_size((schemaname||'.'||tablename)::regclass)) AS total_size,
			pg_size_pretty(pg_relation_size((schemaname||'.'||tablename)::regclass)) AS table_size,
			pg_size_pretty(pg_total_relation_size((schemaname||'.'||tablename)::regclass) - pg_relation_size((schemaname||'.'||tablename)::regclass)) AS index_size,
			n_dead_tup,
			n_live_tup,
			CASE 
				WHEN n_live_tup > 0 THEN (n_dead_tup::float / n_live_tup::float) * 100
				ELSE 0
			END AS bloat_ratio,
			last_vacuum,
			last_autovacuum
		FROM pg_stat_user_tables
		WHERE tablename = $1
	`

	stats := &TableStats{}
	var lastVacuum, lastAutoVacuum sql.NullTime

	err := m.db.QueryRow(query, tableName).Scan(
		&stats.TableName,
		&stats.TotalSize,
		&stats.TableSize,
		&stats.IndexSize,
		&stats.DeadTuples,
		&stats.LiveTuples,
		&stats.BloatRatio,
		&lastVacuum,
		&lastAutoVacuum,
	)

	if err != nil {
		m.logger.Error("Failed to get table stats", "table", tableName, "error", err)
		return nil, err
	}

	if lastVacuum.Valid {
		stats.LastVacuum = &lastVacuum.Time
	}
	if lastAutoVacuum.Valid {
		stats.LastAutoVacuum = &lastAutoVacuum.Time
	}

	return stats, nil
}

func (m *DBMaintenance) GetHighActivityTableStats() ([]TableStats, error) {
	// Get stats for high-activity tables
	highActivityTables := []string{
		"entities",
		"media",
		"media_images",
		"feed",
		"feed_session_mapping",
		"user_sessions",
	}

	var allStats []TableStats
	for _, tableName := range highActivityTables {
		stats, err := m.GetTableStats(tableName)
		if err != nil {
			m.logger.Warn("Failed to get stats for table", "table", tableName, "error", err)
			continue
		}
		if stats != nil {
			allStats = append(allStats, *stats)
		}
	}

	return allStats, nil
}
