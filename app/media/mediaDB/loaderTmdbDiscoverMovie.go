package mediaDB

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

type LoaderTmdbDiscoverMovie struct {
	Logger       *slog.Logger
	DB           *sql.DB
	UpsertEntity *entityDB.UpsertEntity
	TmdbClient   *tmdbAPI.Client
	MaxPages     int
}

func NewLoaderTmdbDiscoverMovie(logger *slog.Logger, db *sql.DB, upsertEntity *entityDB.UpsertEntity, tmdbClient *tmdbAPI.Client) *LoaderTmdbDiscoverMovie {
	return &LoaderTmdbDiscoverMovie{
		Logger:       logger.WithGroup("loaderTmdbDiscoverMovie"),
		DB:           db,
		UpsertEntity: upsertEntity,
		TmdbClient:   tmdbClient,
		MaxPages:     TMDB_DISCOVER_MOVIE_HARD_MAX_PAGES,
	}
}

func (l *LoaderTmdbDiscoverMovie) beginTransaction() (*sql.Tx, error) {
	tx, err := l.DB.Begin()
	if err != nil {
		return nil, fmt.Errorf("failed to begin transaction: %v", err)
	}
	l.Logger.Debug("Starting database transaction")
	return tx, nil
}

func (l *LoaderTmdbDiscoverMovie) processMovie(movie tmdbAPI.DiscoverMovieResponseResult) error {
	l.Logger.Debug("Processing movie", "title", movie.Title, "id", movie.ID)
	l.Logger.Debug("Movie details", "title", movie.Title, "popularity", movie.Popularity, "releaseDate", movie.ReleaseDate)

	tx, err := l.beginTransaction()
	if err != nil {
		return err
	}
	defer tx.Rollback()

	// Store TMDB movie data in entities
	if err := l.UpsertEntity.Execute(tx, "tmdb/movie", strconv.FormatInt(int64(movie.ID), 10), movie); err != nil {
		return err
	}

	if err := tx.Commit(); err != nil {
		return fmt.Errorf("failed to commit transaction: %v", err)
	}

	l.Logger.Debug("Successfully stored TMDB movie data", "movieID", movie.ID)
	return nil
}

func (l *LoaderTmdbDiscoverMovie) processMoviePage(page int) (bool, error) {
	l.Logger.Debug("Fetching page of movies from TMDB API", "page", page)

	response, err := l.TmdbClient.DiscoverMovie(tmdbAPI.DiscoverMovieParams{
		Page: page,
	})
	if err != nil {
		l.Logger.Error("Failed to get page", "page", page, "error", err)
		return false, err
	}

	l.Logger.Debug("Retrieved movies", "count", len(response.Results), "page", page, "totalPages", response.TotalPages)

	for i, movieResult := range response.Results {
		l.Logger.Debug("Processing movie", "number", i+1, "total", len(response.Results), "page", page)

		if err := l.processMovie(movieResult); err != nil {
			return false, err
		}
	}

	l.Logger.Debug("Successfully processed page", "page", page, "movieCount", len(response.Results))
	return page >= response.TotalPages, nil
}

func (l *LoaderTmdbDiscoverMovie) processPages(logger *slog.Logger, page *int, done chan struct{}) {
	for *page = 1; *page <= l.MaxPages && *page <= TMDB_DISCOVER_MOVIE_HARD_MAX_PAGES; *page++ {
		time.Sleep(0 * time.Second)

		isLastPage, err := l.processMoviePage(*page)
		if err != nil {
			logger.Error("Failed to process page", "page", *page, "error", err)
			close(done)
			return
		}

		if isLastPage {
			logger.Debug("Reached last page, media loader complete")
			close(done)
			return
		}
	}

	logger.Debug("TMDB Discover Movie loader completed")
	close(done)
}

func (l *LoaderTmdbDiscoverMovie) goStatusLogger(logger *slog.Logger, page *int, done chan struct{}) {
	ticket := time.NewTicker(3 * time.Second)
	go func() {
		logger.Info("Loader status", "currentPage", *page)
		for {
			select {
			case <-ticket.C:
				logger.Info("Loader status", "currentPage", *page)
			case <-done:
				ticket.Stop()
				return
			}
		}
	}()
}

func (l *LoaderTmdbDiscoverMovie) goLoader(page *int, done chan struct{}) {
	go func() {
		l.processPages(l.Logger, page, done)
	}()
}

func (l *LoaderTmdbDiscoverMovie) Run() chan struct{} {
	done := make(chan struct{})
	page := 0
	l.goStatusLogger(l.Logger, &page, done)
	l.goLoader(&page, done)
	return done
}
