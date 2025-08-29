package workerLoadTMDB

import (
	"database/sql"
	"fmt"
	"log/slog"
	"movieFinder/app/entityDB"
	"movieFinder/lib/tmdbAPI"
	"strconv"
	"time"
)

const TMDB_DISCOVER_MOVIE_HARD_MAX_PAGES = 500

type WorkerLoadTMDBDiscoverMovie struct {
	Logger       *slog.Logger
	DB           *sql.DB
	UpsertEntity *entityDB.UpsertEntity
	TmdbClient   *tmdbAPI.Client
	MaxPages     int
}

func newWorkerLoadTMDBDiscoverMovie(logger *slog.Logger, db *sql.DB, upsertEntity *entityDB.UpsertEntity, tmdbClient *tmdbAPI.Client) *WorkerLoadTMDBDiscoverMovie {
	return &WorkerLoadTMDBDiscoverMovie{
		Logger:       logger.WithGroup("loaderTmdbDiscoverMovie"),
		DB:           db,
		UpsertEntity: upsertEntity,
		TmdbClient:   tmdbClient,
		MaxPages:     TMDB_DISCOVER_MOVIE_HARD_MAX_PAGES,
	}
}

func (l *WorkerLoadTMDBDiscoverMovie) Run() chan struct{} {
	params := tmdbAPI.DiscoverMovieParams{Page: 0}
	done := l.startLoader(params)
	return done
}

func (l *WorkerLoadTMDBDiscoverMovie) startLoader(params tmdbAPI.DiscoverMovieParams) chan struct{} {
	done := make(chan struct{})
	currentPage := 0
	startTime := time.Now()

	go func() {
		defer close(done)

		for page := 1; page <= l.MaxPages && page <= TMDB_DISCOVER_MOVIE_HARD_MAX_PAGES; page++ {
			currentPage = page
			params.Page = page
			pageStartTime := time.Now()

			l.Logger.Info("Starting to process page", "page", page, "maxPages", l.MaxPages, "hardMaxPages", TMDB_DISCOVER_MOVIE_HARD_MAX_PAGES, "elapsed", time.Since(startTime))

			// Add timeout for individual page processing
			pageDone := make(chan struct{})
			var isLastPage bool
			var err error

			go func() {
				isLastPage, err = l.loadPage(params)
				close(pageDone)
			}()

			select {
			case <-pageDone:
				// Page completed successfully
			case <-time.After(5 * time.Minute): // 5 minute timeout per page
				l.Logger.Error("Page processing timeout", "page", page, "timeout", "5 minutes")
				return
			}

			if err != nil {
				l.Logger.Error("Failed to process page", "page", page, "error", err)
				return
			}

			l.Logger.Info("Completed page", "page", page, "duration", time.Since(pageStartTime), "isLastPage", isLastPage)

			if isLastPage {
				l.Logger.Info("Reached last page, media loader complete", "page", page, "totalPages", params.Page, "totalDuration", time.Since(startTime))
				return
			}
		}
		l.Logger.Info("TMDB Discover Movie loader completed", "maxPages", l.MaxPages, "hardMaxPages", TMDB_DISCOVER_MOVIE_HARD_MAX_PAGES, "finalPage", currentPage, "totalDuration", time.Since(startTime))
	}()

	go func() {
		timeout := time.After(30 * time.Minute)
		select {
		case <-timeout:
			l.Logger.Error("Worker timeout reached, forcing shutdown")
			close(done)
		case <-done:
			break
		}
	}()

	go func() {
		ticker := time.NewTicker(3 * time.Second)
		defer ticker.Stop()
		l.Logger.Info("Loader status", "currentPage", currentPage)
		for {
			select {
			case <-ticker.C:
				l.Logger.Info("Loader status", "currentPage", currentPage)
			case <-done:
				l.Logger.Info("Status logger shutting down")
				return
			}
		}
	}()

	return done
}

func (l *WorkerLoadTMDBDiscoverMovie) loadPage(params tmdbAPI.DiscoverMovieParams) (bool, error) {
	l.Logger.Debug("Fetching page of movies from TMDB API", "page", params.Page)

	response, err := l.TmdbClient.DiscoverMovie(params)

	if err != nil {
		l.Logger.Error("Failed to get page", "page", params.Page, "error", err)
		return false, err
	}

	l.Logger.Debug("Retrieved movies", "count", len(response.Results), "page", params.Page, "totalPages", response.TotalPages)

	// Safety check: if we get no results, this might be the last page
	if len(response.Results) == 0 {
		l.Logger.Warn("Received empty page results", "page", params.Page, "totalPages", response.TotalPages)
		return true, nil
	}

	// Check if this is the last page
	isLastPage := params.Page >= response.TotalPages
	l.Logger.Debug("Page analysis", "currentPage", params.Page, "totalPages", response.TotalPages, "isLastPage", isLastPage)

	tx, err := l.DB.Begin()

	if err != nil {
		return false, err
	}

	defer tx.Rollback()

	for i, movieResult := range response.Results {
		l.Logger.Debug("Processing movie", "number", i+1, "total", len(response.Results), "page", params.Page)

		if err := l.upsertMovie(tx, movieResult); err != nil {
			return false, err
		}
	}

	if err := tx.Commit(); err != nil {
		return false, fmt.Errorf("failed to commit transaction: %v", err)
	}

	l.Logger.Debug("Successfully processed page", "page", params.Page, "movieCount", len(response.Results))

	return isLastPage, nil
}

func (l *WorkerLoadTMDBDiscoverMovie) upsertMovie(tx *sql.Tx, movie tmdbAPI.DiscoverMovieResponseResult) error {
	l.Logger.Debug("Processing movie", "title", movie.Title, "id", movie.ID)

	l.Logger.Debug("Movie details", "title", movie.Title, "popularity", movie.Popularity, "releaseDate", movie.ReleaseDate)

	if err := l.UpsertEntity.Execute(tx, "tmdb/movie", strconv.FormatInt(int64(movie.ID), 10), movie); err != nil {
		return err
	}

	l.Logger.Debug("Successfully stored TMDB movie data", "movieID", movie.ID)
	return nil
}
