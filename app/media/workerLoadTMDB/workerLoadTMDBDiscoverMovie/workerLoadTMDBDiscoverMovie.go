package workerLoadTMDBDiscoverMovie

import (
	"database/sql"
	"fmt"
	"log/slog"
	"movieFinder/app/entityDB"
	"movieFinder/lib/tmdbAPI"
	"strconv"
	"time"
)

type Worker struct {
	logger       *slog.Logger
	db           *sql.DB
	upsertEntity *entityDB.UpsertEntity
	tmdbClient   *tmdbAPI.Client
	maxPages     int
}

func New(logger *slog.Logger, db *sql.DB, upsertEntity *entityDB.UpsertEntity, tmdbClient *tmdbAPI.Client) *Worker {
	return &Worker{
		logger:       logger.WithGroup("discoverMovie"),
		db:           db,
		upsertEntity: upsertEntity,
		tmdbClient:   tmdbClient,
		maxPages:     500,
	}
}

func (l *Worker) Start() chan struct{} {
	params := tmdbAPI.DiscoverMovieParams{Page: 0}
	done := l.startLoader(params)
	return done
}

func (l *Worker) startLoader(params tmdbAPI.DiscoverMovieParams) chan struct{} {
	done := make(chan struct{})
	currentPage := 0
	startTime := time.Now()

	go func() {
		defer close(done)

		for page := 1; page <= l.maxPages; page++ {
			currentPage = page
			params.Page = page
			pageStartTime := time.Now()

			l.logger.Info("Starting to process page", "page", page, "maxPages", l.maxPages, "hardMaxPages", l.maxPages, "elapsed", time.Since(startTime))

			pageDone := make(chan struct{})
			var isLastPage bool
			var err error

			go func() {
				isLastPage, err = l.loadPage(params)
				close(pageDone)
			}()

			select {
			case <-pageDone:
			case <-time.After(5 * time.Minute):
				l.logger.Error("Page processing timeout", "page", page, "timeout", "5 minutes")
				return
			}

			if err != nil {
				l.logger.Error("Failed to process page", "page", page, "error", err)
				return
			}

			l.logger.Info("Completed page", "page", page, "duration", time.Since(pageStartTime), "isLastPage", isLastPage)

			if isLastPage {
				l.logger.Info("Reached last page, media loader complete", "page", page, "totalPages", params.Page, "totalDuration", time.Since(startTime))
				return
			}
		}
		l.logger.Info("TMDB Discover Movie loader completed", "maxPages", l.maxPages, "hardMaxPages", l.maxPages, "finalPage", currentPage, "totalDuration", time.Since(startTime))
	}()

	go func() {
		timeout := time.After(30 * time.Minute)
		select {
		case <-timeout:
			l.logger.Error("Worker timeout reached, forcing shutdown")
			close(done)
		case <-done:
			break
		}
	}()

	go func() {
		ticker := time.NewTicker(3 * time.Second)
		defer ticker.Stop()
		l.logger.Info("Loader status", "currentPage", currentPage)
		for {
			select {
			case <-ticker.C:
				l.logger.Info("Loader status", "currentPage", currentPage)
			case <-done:
				l.logger.Info("Status logger shutting down")
				return
			}
		}
	}()

	return done
}

func (l *Worker) loadPage(params tmdbAPI.DiscoverMovieParams) (bool, error) {
	l.logger.Debug("Fetching page of movies from TMDB API", "page", params.Page)

	response, err := l.tmdbClient.DiscoverMovie(params)

	if err != nil {
		l.logger.Error("Failed to get page", "page", params.Page, "error", err)
		return false, err
	}

	l.logger.Debug("Retrieved movies", "count", len(response.Results), "page", params.Page, "totalPages", response.TotalPages)

	if len(response.Results) == 0 {
		l.logger.Warn("Received empty page results", "page", params.Page, "totalPages", response.TotalPages)
		return true, nil
	}

	isLastPage := params.Page >= response.TotalPages
	l.logger.Debug("Page analysis", "currentPage", params.Page, "totalPages", response.TotalPages, "isLastPage", isLastPage)

	tx, err := l.db.Begin()

	if err != nil {
		return false, err
	}

	defer tx.Rollback()

	for i, movieResult := range response.Results {
		l.logger.Debug("Processing movie", "number", i+1, "total", len(response.Results), "page", params.Page)

		if err := l.upsertMovie(tx, movieResult); err != nil {
			return false, err
		}
	}

	if err := tx.Commit(); err != nil {
		return false, fmt.Errorf("failed to commit transaction: %v", err)
	}

	l.logger.Debug("Successfully processed page", "page", params.Page, "movieCount", len(response.Results))

	return isLastPage, nil
}

func (l *Worker) upsertMovie(tx *sql.Tx, movie tmdbAPI.DiscoverMovieResponseResult) error {
	l.logger.Debug("Processing movie", "title", movie.Title, "id", movie.ID)

	l.logger.Debug("Movie details", "title", movie.Title, "popularity", movie.Popularity, "releaseDate", movie.ReleaseDate)

	if err := l.upsertEntity.Execute(tx, "tmdb/movie", strconv.FormatInt(int64(movie.ID), 10), movie); err != nil {
		return err
	}

	l.logger.Debug("Successfully stored TMDB movie data", "movieID", movie.ID)
	return nil
}
