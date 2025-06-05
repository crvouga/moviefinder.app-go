package mediaDB

import (
	"testing"
)

func TestLoaderTmdbAPIDiscoverMovie(t *testing.T) {
	f := NewFixture()
	defer f.DB.Close()

	err := LoaderTmdbAPIDiscoverMovie(f.DB, f.Client, 1)
	if err != nil {
		t.Errorf("Expected no error, got %v", err)
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
