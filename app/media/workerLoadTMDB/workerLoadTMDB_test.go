package workerLoadTMDB

import (
	"context"
	"database/sql"
	"log/slog"
	"movieFinder/app/entityDB"
	"movieFinder/lib/tmdbAPI"
	"testing"
	"time"
)

func TestNew(t *testing.T) {
	// Setup test dependencies
	logger := slog.Default()
	db := &sql.DB{}
	upsertEntity := &entityDB.UpsertEntity{}
	tmdbClient := &tmdbAPI.Client{}

	// Create new worker
	worker := New(logger, db, upsertEntity, tmdbClient)

	// Verify worker and its components are initialized
	if worker == nil {
		t.Error("Expected worker to not be nil")
	}

	if worker.logger == nil {
		t.Error("Expected logger to be initialized")
	}

	if worker.workerLoadTMDBConfiguration == nil {
		t.Error("Expected configuration worker to be initialized")
	}

	if worker.workerLoadTMDBGenresMovie == nil {
		t.Error("Expected genres worker to be initialized")
	}

	if worker.workerLoadTMDBMovieDetails == nil {
		t.Error("Expected movie details worker to be initialized")
	}

	if worker.workerLoadTMDBDiscoverMovie == nil {
		t.Error("Expected discover movie worker to be initialized")
	}
}

func TestStart(t *testing.T) {
	// Setup test dependencies
	logger := slog.Default()
	db := &sql.DB{}
	upsertEntity := &entityDB.UpsertEntity{}
	tmdbClient := &tmdbAPI.Client{}

	worker := New(logger, db, upsertEntity, tmdbClient)

	// Start the worker
	done := worker.Start(context.Background())

	// Verify done channel is created
	if done == nil {
		t.Error("Expected done channel to not be nil")
	}

	// Wait for the worker to complete
	<-done
}

func TestStop(t *testing.T) {
	// Setup test dependencies
	logger := slog.Default()
	db := &sql.DB{}
	upsertEntity := &entityDB.UpsertEntity{}
	tmdbClient := &tmdbAPI.Client{}

	worker := New(logger, db, upsertEntity, tmdbClient)

	// Start the worker
	done := worker.Start(context.Background())

	// Stop the worker
	worker.Stop()

	// Verify the worker stops gracefully
	select {
	case <-done:
		// Worker stopped as expected
	case <-time.After(1 * time.Second):
		t.Error("Expected worker to stop within 1 second")
	}
}
