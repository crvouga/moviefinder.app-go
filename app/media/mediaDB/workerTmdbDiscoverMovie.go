package mediaDB

import (
	"database/sql"
	"fmt"
	"log/slog"
	"movieFinder/lib/tmdbAPI"
	"strconv"
	"time"
)

const HARD_MAX_PAGES = 500

func (w *Worker) processMovie(movie tmdbAPI.DiscoverMovieResponseResult) error {
	w.Logger.Debug("Processing movie", "title", movie.Title, "id", movie.ID)
	w.Logger.Debug("Movie details", "title", movie.Title, "popularity", movie.Popularity, "releaseDate", movie.ReleaseDate)

	tx, err := w.beginTransaction()
	if err != nil {
		return err
	}
	defer tx.Rollback()

	// Store TMDB movie data in entities
	if err := w.upsertEntity.Execute(tx, "tmdb/movie", strconv.FormatInt(int64(movie.ID), 10), movie); err != nil {
		return err
	}

	if err := tx.Commit(); err != nil {
		return fmt.Errorf("failed to commit transaction: %v", err)
	}

	w.Logger.Debug("Successfully stored TMDB movie data", "movieID", movie.ID)
	return nil
}

func (w *Worker) beginTransaction() (*sql.Tx, error) {
	tx, err := w.DB.Begin()
	if err != nil {
		return nil, fmt.Errorf("failed to begin transaction: %v", err)
	}
	w.Logger.Debug("Starting database transaction")
	return tx, nil
}

func (w *Worker) processMoviePage(page int) (bool, error) {
	w.Logger.Debug("Fetching page of movies from TMDB API", "page", page)

	response, err := w.tmdbClient.DiscoverMovie(tmdbAPI.DiscoverMovieParams{
		Page: page,
	})
	if err != nil {
		w.Logger.Error("Failed to get page", "page", page, "error", err)
		return false, err
	}

	w.Logger.Debug("Retrieved movies", "count", len(response.Results), "page", page, "totalPages", response.TotalPages)

	for i, movieResult := range response.Results {
		w.Logger.Debug("Processing movie", "number", i+1, "total", len(response.Results), "page", page)
		if err := w.processMovie(movieResult); err != nil {
			return false, err // Return error to stop processing
		}
	}

	w.Logger.Debug("Successfully processed page", "page", page, "movieCount", len(response.Results))
	return page >= response.TotalPages, nil
}

func (w *Worker) startStatusTracker(logger *slog.Logger, page *int, done chan struct{}) {
	statusTicker := time.NewTicker(5 * time.Second)
	go func() {
		logger.Info("Worker status", "currentPage", *page)
		for {
			select {
			case <-statusTicker.C:
				logger.Info("Worker status", "currentPage", *page)
			case <-done:
				statusTicker.Stop()
				return
			}
		}
	}()
}

func (w *Worker) processPages(logger *slog.Logger, page *int, done chan struct{}) {
	for *page = 1; *page <= w.DiscoverMovieMaxPages && *page <= HARD_MAX_PAGES; *page++ {
		time.Sleep(0 * time.Second)

		isLastPage, err := w.processMoviePage(*page)
		if err != nil {
			logger.Error("Failed to process page", "page", *page, "error", err)
			close(done)
			return
		}

		if isLastPage {
			logger.Debug("Reached last page, media worker complete")
			close(done)
			return
		}
	}

	logger.Debug("TMDB Discover Movie worker completed")
	close(done)
}

func (w *Worker) WorkerDiscoverMovieLoader() chan struct{} {
	logger := w.Logger.WithGroup("workerDiscoverMovie")
	done := make(chan struct{})
	page := 0

	go func() {
		if _, err := w.upsertConfiguration(logger); err != nil {
			logger.Error("Failed to upsert configuration", "error", err)
			close(done)
			return
		}
		if _, err := w.upsertGenresMovie(logger); err != nil {
			logger.Error("Failed to upsert genres movie", "error", err)
			close(done)
			return
		}
		logger.Info("Starting TMDB Discover Movie worker")
		logger.Info("Processing pages", "maxPages", w.DiscoverMovieMaxPages)

		w.processPages(logger, &page, done)
	}()

	w.startStatusTracker(logger, &page, done)

	return done
}
