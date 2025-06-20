package mediaDB

import (
	"log/slog"
	"testing"
	"time"
)

func TestWorker(t *testing.T) {
	f := NewFixture()
	defer f.DB.Close()

	worker := NewWorker(f.DB, f.Client, slog.Default())
	worker.DiscoverMovieMaxPages = 1
	worker.DiscoverMovieThrottle = 0 * time.Second
	done := worker.Run()

	t.Log("waiting for worker to complete")
	<-done
	t.Log("worker completed")

	var count int
	err := f.DB.QueryRow("SELECT COUNT(*) FROM media").Scan(&count)
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
