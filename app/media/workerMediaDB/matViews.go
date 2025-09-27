package workerMediaDB

import (
	"database/sql"
	_ "embed"
	"fmt"
	"log/slog"
	"strings"
	"time"
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
		m.logger.Error("Failed to run up migration", "error", err)
		return err
	}
	m.logger.Info("Successfully ran up migration")
	return err
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
	if err := m.Down(); err != nil {
		m.logger.Error("Failed to run down migration during init", "error", err)
		return err
	}
	if err := m.Up(); err != nil {
		m.logger.Error("Failed to run up migration during init", "error", err)
		return err
	}
	if err := m.refresh(); err != nil {
		m.logger.Error("Failed to refresh views during init", "error", err)
		return err
	}
	m.logger.Info("Successfully initialized materialized views")
	return nil
}
