package mediaDB

import (
	"log/slog"
	"testing"
	"time"
)

func TestQueryPopularMedia(t *testing.T) {
	f := NewFixture()
	defer f.DB.Close()

	// Load one page of movies
	worker := NewWorker(f.DB, f.Client, slog.Default())
	worker.DiscoverMovieMaxPages = 1
	done := worker.Run()

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
		if m.ID == "" {
			t.Error("Expected non-empty ID")
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
