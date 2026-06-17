package dbMaintenance

import (
	"database/sql"
	"fmt"
	"log/slog"
	"movieFinder/lib/postgres"
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

// HighActivityTables are user tables monitored and vacuumed by the maintenance worker.
var HighActivityTables = []string{
	"entities",
	"feed",
	"feed_session_mapping",
	"user_sessions",
	"user_accounts",
}

func qualifiedTable(tableName string) string {
	return postgres.SchemaName + "." + tableName
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
	query := fmt.Sprintf("VACUUM ANALYZE %s", qualifiedTable(tableName))
	if _, err := m.db.Exec(query); err != nil {
		m.logger.Error("VACUUM ANALYZE table failed", "table", tableName, "error", err, "duration", time.Since(start))
		return err
	}
	m.logger.Info("VACUUM ANALYZE table completed", "table", tableName, "duration", time.Since(start))
	return nil
}

func (m *DBMaintenance) VacuumFull(tableName string) error {
	start := time.Now()
	query := fmt.Sprintf("VACUUM FULL ANALYZE %s", qualifiedTable(tableName))
	if _, err := m.db.Exec(query); err != nil {
		m.logger.Error("VACUUM FULL ANALYZE table failed", "table", tableName, "error", err, "duration", time.Since(start))
		return err
	}
	m.logger.Info("VACUUM FULL ANALYZE table completed", "table", tableName, "duration", time.Since(start))
	return nil
}

func (m *DBMaintenance) AnalyzeTable(tableName string) error {
	start := time.Now()
	query := fmt.Sprintf("ANALYZE %s", qualifiedTable(tableName))
	if _, err := m.db.Exec(query); err != nil {
		m.logger.Error("ANALYZE table failed", "table", tableName, "error", err, "duration", time.Since(start))
		return err
	}
	m.logger.Info("ANALYZE table completed", "table", tableName, "duration", time.Since(start))
	return nil
}

func (m *DBMaintenance) ReindexConcurrently() error {
	start := time.Now()
	query := fmt.Sprintf("REINDEX SCHEMA CONCURRENTLY %s", postgres.SchemaName)
	if _, err := m.db.Exec(query); err != nil {
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
			n.nspname || '.' || c.relname AS table_name,
			pg_size_pretty(pg_total_relation_size(c.oid)) AS total_size,
			pg_size_pretty(pg_relation_size(c.oid)) AS table_size,
			pg_size_pretty(pg_total_relation_size(c.oid) - pg_relation_size(c.oid)) AS index_size,
			s.n_dead_tup,
			s.n_live_tup,
			CASE
				WHEN s.n_live_tup > 0 THEN (s.n_dead_tup::float / s.n_live_tup::float) * 100
				ELSE 0
			END AS bloat_ratio,
			s.last_vacuum,
			s.last_autovacuum
		FROM pg_stat_user_tables s
		JOIN pg_class c ON c.oid = s.relid
		JOIN pg_namespace n ON n.oid = c.relnamespace
		WHERE n.nspname = $1 AND c.relname = $2
	`

	stats := &TableStats{}
	var lastVacuum, lastAutoVacuum sql.NullTime

	err := m.db.QueryRow(query, postgres.SchemaName, tableName).Scan(
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
	var allStats []TableStats
	for _, tableName := range HighActivityTables {
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
