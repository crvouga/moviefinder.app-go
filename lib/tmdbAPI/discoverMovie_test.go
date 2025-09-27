package tmdbAPI

import (
	"testing"
)

func TestDiscoverMovie(t *testing.T) {
	f := NewFixture()

	params := DiscoverMovieParams{
		Page:         1,
		IncludeAdult: false,
	}

	response, err := f.tmdbAPI.DiscoverMovie(params)
	if err != nil {
		t.Fatalf("DiscoverMovie returned error: %v", err)
	}

	// Check that we got some results back
	if len(response.Results) == 0 {
		t.Error("Expected results but got none")
	}

	// Check that page info is valid
	if response.Page < 1 {
		t.Error("Expected page number to be >= 1")
	}

	if response.TotalPages < 1 {
		t.Error("Expected total pages to be >= 1")
	}

	if response.TotalResults < 1 {
		t.Error("Expected total results to be >= 1")
	}

	// Check that first result has required fields
	firstResult := response.Results[0]
	if firstResult.ID == 0 {
		t.Error("Expected movie ID to be non-zero")
	}

	if firstResult.Title == "" {
		t.Error("Expected movie title to be non-empty")
	}
}
