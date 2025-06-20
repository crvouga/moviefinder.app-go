package mediaDB

import (
	"log/slog"
	"testing"
	"time"
)

func TestQueryMediaByID(t *testing.T) {
	f := NewFixture()
	defer f.DB.Close()

	// Load one page of movies
	worker, err := NewWorker(f.DB, f.Client, slog.Default())
	if err != nil {
		t.Fatalf("Expected no error creating worker, got %v", err)
	}
	defer worker.Close()

	worker.DiscoverMovieMaxPages = 1
	done := worker.Run()

	// Wait for loading to complete
	select {
	case <-done:
		// Loading completed successfully
	case <-time.After(5 * time.Second):
		t.Fatal("Timeout waiting for movie loading to complete")
	}

	queryMediaByID, err := NewQueryMediaByID(f.DB)
	if err != nil {
		t.Errorf("Expected no error creating query media by ID, got %v", err)
	}

	// Get a media ID from the database to test with
	queryPopular, err := NewQueryPopularMedia(f.DB)
	if err != nil {
		t.Errorf("Expected no error creating query popular media, got %v", err)
	}

	results, err := queryPopular.Query(1, 0)
	if err != nil {
		t.Errorf("Expected no error querying popular media, got %v", err)
	}
	if len(results) == 0 {
		t.Fatal("Expected at least one result to test with")
	}

	// Test querying for a specific media ID
	mediaID := results[0].ID
	media, err := queryMediaByID.Query(mediaID)
	if err != nil {
		t.Errorf("Expected no error querying media by ID, got %v", err)
	}
	if media == nil {
		t.Error("Expected to find media, got nil")
	}

	// Verify the media fields
	if media.ID != mediaID {
		t.Errorf("Expected ID %s, got %s", mediaID, media.ID)
	}
	if media.Title == "" {
		t.Error("Expected non-empty title")
	}
	if media.Description == "" {
		t.Error("Expected non-empty description")
	}
	if media.Popularity == 0 {
		t.Error("Expected non-zero popularity")
	}

	// Test querying for non-existent ID
	media, err = queryMediaByID.Query("non-existent-id")
	if err != nil {
		t.Errorf("Expected no error querying non-existent ID, got %v", err)
	}
	if media != nil {
		t.Error("Expected nil result for non-existent ID")
	}
}
