package mediaDB

import (
	"database/sql"
	_ "embed"
	"log/slog"
	"strings"
	"time"
)

type MediaDbMatViews struct {
	db     *sql.DB
	logger *slog.Logger
}

//go:embed matViews.sql
var matViewsSQL string

func NewMediaDbMatViews(db *sql.DB, logger *slog.Logger) *MediaDbMatViews {
	return &MediaDbMatViews{
		db:     db,
		logger: logger.WithGroup("mediaDBMatViews"),
	}
}

func (m *MediaDbMatViews) Up() error {
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

func (m *MediaDbMatViews) Down() error {
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

func (m *MediaDbMatViews) Refresh() error {
	m.logger.Debug("Refreshing materialized views")
	_, err := m.db.Exec("SELECT refresh_media_mv()")
	if err != nil {
		m.logger.Error("Failed to refresh materialized views", "error", err)
		return err
	}
	m.logger.Debug("Successfully refreshed materialized views")
	return err
}

func (m *MediaDbMatViews) Init() error {
	m.logger.Info("Initializing materialized views")
	if err := m.Down(); err != nil {
		m.logger.Error("Failed to run down migration during init", "error", err)
		return err
	}
	if err := m.Up(); err != nil {
		m.logger.Error("Failed to run up migration during init", "error", err)
		return err
	}
	if err := m.Refresh(); err != nil {
		m.logger.Error("Failed to refresh views during init", "error", err)
		return err
	}
	m.logger.Info("Successfully initialized materialized views")
	return nil
}

func (m *MediaDbMatViews) RefreshWorker() chan struct{} {
	done := make(chan struct{})
	logger := m.logger.WithGroup("workerMatViews")

	go func() {
		logger.Info("Starting materialized views refresh worker")
		ticker := time.NewTicker(10 * time.Second)
		defer ticker.Stop()

		for {
			select {
			case <-ticker.C:
				if err := m.Refresh(); err != nil {
					logger.Error("Failed to refresh materialized views", "error", err)
				}
			case <-done:
				logger.Info("Stopping materialized views refresh worker")
				return
			}
		}
	}()

	return done
}
