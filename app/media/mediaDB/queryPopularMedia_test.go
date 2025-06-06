package mediaDB

import (
	"testing"
	"time"
)

func TestQueryPopularMedia(t *testing.T) {
	f := NewFixture()
	defer f.DB.Close()

	// Create tables before running the test
	err := CreateTables(f.DB)
	if err != nil {
		t.Fatalf("Failed to create tables: %v", err)
	}

	// Load one page of movies
	done := make(chan struct{})
	err = LoaderTmdbAPIDiscoverMovie(f.DB, f.Client, 1, done)
	if err != nil {
		t.Errorf("Expected no error loading movies, got %v", err)
	}

	// Wait for loading to complete
	select {
	case <-done:
		// Loading completed successfully
	case <-time.After(5 * time.Second):
		t.Fatal("Timeout waiting for movie loading to complete")
	}

	queryPopularMedia, err := NewQueryPopularMedia(f.DB)

	if err != nil {
		t.Errorf("Expected no error creating query popular media, got %v", err)
	}

	// Test the query
	results, err := queryPopularMedia.Query(10, 0)
	if err != nil {
		t.Errorf("Expected no error querying popular media, got %v", err)
	}

	// Verify results
	if len(results) == 0 {
		t.Error("Expected results to contain movies, got empty slice")
	}

	// Verify movies are ordered by popularity
	for i := 0; i < len(results)-1; i++ {
		if results[i].Popularity < results[i+1].Popularity {
			t.Errorf("Expected movies to be ordered by descending popularity, but %f came before %f",
				results[i].Popularity, results[i+1].Popularity)
		}
	}

	// Check that we got the expected fields
	for _, m := range results {
		if m.ID == 0 {
			t.Error("Expected non-zero ID")
		}
		if m.Title == "" {
			t.Error("Expected non-empty title")
		}
		if m.Description == "" {
			t.Error("Expected non-empty description")
		}
		if m.Popularity == 0 {
			t.Error("Expected non-zero popularity")
		}
	}
}
