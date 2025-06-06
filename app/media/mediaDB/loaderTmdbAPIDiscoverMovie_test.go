package mediaDB

import (
	"testing"
	"time"
)

func TestLoaderTmdbAPIDiscoverMovie(t *testing.T) {
	f := NewFixture()
	defer f.DB.Close()

	done := make(chan struct{})
	err := LoaderTmdbAPIDiscoverMovie(f.DB, f.Client, 1, done)
	if err != nil {
		t.Errorf("Expected no error, got %v", err)
	}

	// Wait for loading to complete with timeout
	select {
	case <-done:
		// Loading completed successfully
	case <-time.After(10 * time.Second):
		t.Fatal("Timeout waiting for movie loading to complete")
	}

	var count int
	err = f.DB.QueryRow("SELECT COUNT(*) FROM media").Scan(&count)
	if err != nil {
		t.Errorf("Error counting media rows: %v", err)
	}

	if count == 0 {
		t.Error("Expected movies to be loaded into database, got 0")
	}

	var imageCount int
	err = f.DB.QueryRow("SELECT COUNT(*) FROM media_images").Scan(&imageCount)
	if err != nil {
		t.Errorf("Error counting media_images rows: %v", err)
	}

	if imageCount == 0 {
		t.Error("Expected movie images to be loaded into database, got 0")
	}
}
