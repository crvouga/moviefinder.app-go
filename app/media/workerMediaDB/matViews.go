package workerMediaDB

import (
	"database/sql"
	_ "embed"
	"errors"
	"fmt"
	"log/slog"
	"strings"
	"time"

	"github.com/lib/pq"
)

type MatViews struct {
	db     *sql.DB
	logger *slog.Logger
}

//go:embed matViews.sql
var matViewsSQL string

func NewMatViews(db *sql.DB, logger *slog.Logger) *MatViews {
	return &MatViews{
		db:     db,
		logger: logger.WithGroup("matViews"),
	}
}

func (m *MatViews) Up() error {
	m.logger.Info("Running materialized views up migration")
	parts := strings.Split(matViewsSQL, "-- migrate:down")
	if len(parts) != 2 {
		m.logger.Warn("No down migration found in SQL file")
		return nil
	}
	upSQL := strings.Split(parts[0], "-- migrate:up")[1]

	_, err := m.db.Exec(upSQL)
	if err != nil {
		// Check if error is "already exists" - this is not fatal
		var pqErr *pq.Error
		if errors.As(err, &pqErr) {
			// PostgreSQL error code 42P07 = duplicate_table
			if pqErr.Code == "42P07" || strings.Contains(err.Error(), "already exists") {
				m.logger.Warn("Materialized views already exist, skipping creation", "error", err)
				return nil
			}
		} else if strings.Contains(err.Error(), "already exists") {
			// Fallback check for error message
			m.logger.Warn("Materialized views already exist, skipping creation", "error", err)
			return nil
		}
		m.logger.Error("Failed to run up migration", "error", err)
		return err
	}
	m.logger.Info("Successfully ran up migration")
	return nil
}

func (m *MatViews) Down() error {
	m.logger.Info("Running materialized views down migration")
	parts := strings.Split(matViewsSQL, "-- migrate:down")
	if len(parts) != 2 {
		m.logger.Warn("No down migration found in SQL file")
		return nil
	}
	downSQL := parts[1]

	_, err := m.db.Exec(downSQL)
	if err != nil {
		m.logger.Error("Failed to run down migration", "error", err)
		return err
	}
	m.logger.Info("Successfully ran down migration")
	return err
}

func (m *MatViews) refresh() error {
	m.logger.Info("Refreshing materialized views")
	start := time.Now()
	_, err := m.db.Exec("SELECT refresh_media_mv()")
	duration := time.Since(start)
	if err != nil {
		m.logger.Error("Failed to refresh materialized views", "error", err, "duration", fmt.Sprintf("%.2fs", duration.Seconds()))
		return err
	}
	m.logger.Info("Successfully refreshed materialized views", "duration", fmt.Sprintf("%.2fs", duration.Seconds()))
	return err
}

func (m *MatViews) Init() error {
	m.logger.Info("Initializing materialized views")
	if err := m.Up(); err != nil {
		// Check if error is "already exists" - this is not fatal
		var pqErr *pq.Error
		if errors.As(err, &pqErr) {
			// PostgreSQL error code 42P07 = duplicate_table
			if pqErr.Code == "42P07" || strings.Contains(err.Error(), "already exists") {
				m.logger.Warn("Materialized views already exist, continuing", "error", err)
				return nil
			}
		} else if strings.Contains(err.Error(), "already exists") {
			// Fallback check for error message
			m.logger.Warn("Materialized views already exist, continuing", "error", err)
			return nil
		}
		m.logger.Error("Failed to run up migration during init", "error", err)
		return err
	}
	m.logger.Info("Successfully initialized materialized views")
	return nil
}
