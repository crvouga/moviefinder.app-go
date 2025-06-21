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

func (l *LoaderTmdbDiscoverMovie) Run() chan struct{} {
	params := tmdbAPI.DiscoverMovieParams{Page: 0}
	done := l.startLoader(params)
	return done
}

func (l *LoaderTmdbDiscoverMovie) startLoader(params tmdbAPI.DiscoverMovieParams) chan struct{} {
	page := 0
	done := make(chan struct{})

	go func() {
		for page = 1; page <= l.MaxPages && page <= TMDB_DISCOVER_MOVIE_HARD_MAX_PAGES; page++ {

			params.Page = page

			isLastPage, err := l.loadPage(params)

			if err != nil {
				l.Logger.Error("Failed to process page", "page", page, "error", err)
				close(done)
				return
			}

			if isLastPage {
				l.Logger.Debug("Reached last page, media loader complete")
				close(done)
				return
			}
		}
		l.Logger.Debug("TMDB Discover Movie loader completed")
	}()

	go func() {
		ticker := time.NewTicker(3 * time.Second)
		l.Logger.Info("Loader status", "currentPage", params.Page)
		for {
			select {
			case <-ticker.C:
				l.Logger.Info("Loader status", "currentPage", params.Page)
			case <-done:
				ticker.Stop()
				return
			}
		}
	}()

	return done
}

func (l *LoaderTmdbDiscoverMovie) loadPage(params tmdbAPI.DiscoverMovieParams) (bool, error) {
	l.Logger.Debug("Fetching page of movies from TMDB API", "page", params.Page)

	response, err := l.TmdbClient.DiscoverMovie(params)

	if err != nil {
		l.Logger.Error("Failed to get page", "page", params.Page, "error", err)
		return false, err
	}

	l.Logger.Debug("Retrieved movies", "count", len(response.Results), "page", params.Page, "totalPages", response.TotalPages)

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

	return params.Page >= response.TotalPages, nil
}

func (l *LoaderTmdbDiscoverMovie) upsertMovie(tx *sql.Tx, movie tmdbAPI.DiscoverMovieResponseResult) error {
	l.Logger.Debug("Processing movie", "title", movie.Title, "id", movie.ID)

	l.Logger.Debug("Movie details", "title", movie.Title, "popularity", movie.Popularity, "releaseDate", movie.ReleaseDate)

	if err := l.UpsertEntity.Execute(tx, "tmdb/movie", strconv.FormatInt(int64(movie.ID), 10), movie); err != nil {
		return err
	}

	l.Logger.Debug("Successfully stored TMDB movie data", "movieID", movie.ID)
	return nil
}
