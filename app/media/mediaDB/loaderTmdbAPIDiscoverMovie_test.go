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
	case <-time.After(5 * time.Second):
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

func TestLoaderTmdbAPIDiscoverMovieMultiplePages(t *testing.T) {
	f := NewFixture()
	defer f.DB.Close()

	// First load just 1 page
	done1 := make(chan struct{})
	err := LoaderTmdbAPIDiscoverMovie(f.DB, f.Client, 1, done1)
	if err != nil {
		t.Errorf("Expected no error, got %v", err)
	}

	select {
	case <-done1:
		// Loading completed successfully
	case <-time.After(5 * time.Second):
		t.Fatal("Timeout waiting for first movie loading to complete")
	}

	var countPage1 int
	err = f.DB.QueryRow("SELECT COUNT(*) FROM media").Scan(&countPage1)
	if err != nil {
		t.Errorf("Error counting media rows: %v", err)
	}

	// Now load 2 pages
	f = NewFixture() // Reset the DB
	done2 := make(chan struct{})
	err = LoaderTmdbAPIDiscoverMovie(f.DB, f.Client, 2, done2)
	if err != nil {
		t.Errorf("Expected no error, got %v", err)
	}

	select {
	case <-done2:
		// Loading completed successfully
	case <-time.After(5 * time.Second):
		t.Fatal("Timeout waiting for second movie loading to complete")
	}

	var countPage2 int
	err = f.DB.QueryRow("SELECT COUNT(*) FROM media").Scan(&countPage2)
	if err != nil {
		t.Errorf("Error counting media rows: %v", err)
	}

	if countPage2 <= countPage1 {
		t.Errorf("Expected more movies with 2 pages than 1 page. Got %d movies with 1 page and %d movies with 2 pages", countPage1, countPage2)
	}
}
