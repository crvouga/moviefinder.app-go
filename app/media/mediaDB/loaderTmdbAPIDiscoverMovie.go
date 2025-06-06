package mediaDB

import (
	"database/sql"
	"fmt"
	"log/slog"
	"math"
	"movieFinder/lib/tmdbAPI"
	"strconv"
	"time"
)

func processMovie(db *sql.DB, movie tmdbAPI.DiscoverMovieResponseResult, configuration tmdbAPI.ConfigurationResponse, posterSizes []string, backdropSizes []string, logger *slog.Logger) error {
	logger.Debug("Processing movie", "title", movie.Title, "id", movie.ID)
	logger.Debug("Movie details", "title", movie.Title, "popularity", movie.Popularity, "releaseDate", movie.ReleaseDate)

	posterURLs := tmdbAPI.ToPosterURLs(movie.PosterPath, configuration, posterSizes)
	backdropURLs := tmdbAPI.ToBackdropURLs(movie.BackdropPath, configuration, backdropSizes)

	logger.Debug("Generated URLs", "posterCount", len(posterURLs), "backdropCount", len(backdropURLs))

	// Begin transaction
	tx, err := db.Begin()
	if err != nil {
		return fmt.Errorf("failed to begin transaction: %v", err)
	}
	defer tx.Rollback()

	logger.Debug("Starting database transaction", "movieID", movie.ID)

	// Insert movie
	_, err = tx.Exec(`
		INSERT OR REPLACE INTO media (
			id,
			title,
			description,
			popularity,
			release_date,
			vote_average,
			vote_count,
			runtime
		) VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
		strconv.FormatInt(int64(movie.ID), 10),
		movie.Title,
		movie.Overview,
		movie.Popularity,
		movie.ReleaseDate,
		movie.VoteAverage,
		movie.VoteCount,
		0, // Runtime not available in discover response
	)
	if err != nil {
		return fmt.Errorf("failed to insert movie: %v", err)
	}

	logger.Debug("Inserted base movie data", "movieID", movie.ID)

	// Insert poster images
	for i, posterURL := range posterURLs {
		_, err = tx.Exec(`
			INSERT OR REPLACE INTO media_images (
				id,
				media_id,
				image_type,
				resolution,
				url
			) VALUES (?, ?, ?, ?, ?)`,
			fmt.Sprintf("%d_poster_%d", movie.ID, i),
			strconv.FormatInt(int64(movie.ID), 10),
			"poster",
			posterSizes[i],
			posterURL,
		)
		if err != nil {
			return fmt.Errorf("failed to insert poster image: %v", err)
		}
		logger.Debug("Inserted poster image", "number", i+1, "total", len(posterURLs), "movieID", movie.ID)
	}

	// Insert backdrop images
	for i, backdropURL := range backdropURLs {
		_, err = tx.Exec(`
			INSERT OR REPLACE INTO media_images (
				id,
				media_id,
				image_type,
				resolution,
				url
			) VALUES (?, ?, ?, ?, ?)`,
			fmt.Sprintf("%d_backdrop_%d", movie.ID, i),
			strconv.FormatInt(int64(movie.ID), 10),
			"backdrop",
			backdropSizes[i],
			backdropURL,
		)
		if err != nil {
			return fmt.Errorf("failed to insert backdrop image: %v", err)
		}
		logger.Debug("Inserted backdrop image", "number", i+1, "total", len(backdropURLs), "movieID", movie.ID)
	}

	logger.Debug("Processing genres", "count", len(movie.GenreIds), "movieID", movie.ID)

	// Insert genres and media_genres relationships
	for i, genreID := range movie.GenreIds {
		// Insert genre if not exists
		_, err = tx.Exec(`
			INSERT OR IGNORE INTO genres (id, name) VALUES (?, ?)`,
			strconv.FormatInt(int64(genreID), 10),
			"", // Name will be updated later when we have genre details
		)
		if err != nil {
			return fmt.Errorf("failed to insert genre: %v", err)
		}

		// Create media-genre relationship
		_, err = tx.Exec(`
			INSERT OR IGNORE INTO media_genres (media_id, genre_id) VALUES (?, ?)`,
			strconv.FormatInt(int64(movie.ID), 10),
			strconv.FormatInt(int64(genreID), 10),
		)
		if err != nil {
			return fmt.Errorf("failed to insert media_genre: %v", err)
		}
		logger.Debug("Processed genre", "number", i+1, "total", len(movie.GenreIds), "genreID", genreID, "movieID", movie.ID)
	}

	// Commit transaction
	if err = tx.Commit(); err != nil {
		return fmt.Errorf("failed to commit transaction: %v", err)
	}

	logger.Debug("Successfully completed database transaction", "movieID", movie.ID)
	return nil
}

func processMoviePage(db *sql.DB, client *tmdbAPI.Client, page int, configuration tmdbAPI.ConfigurationResponse, logger *slog.Logger) (bool, error) {
	logger.Info("Fetching page of movies from TMDB API", "page", page)

	response, err := client.DiscoverMovie(tmdbAPI.DiscoverMovieParams{
		Page: page,
	})
	if err != nil {
		logger.Error("Failed to get page", "page", page, "error", err)
		return false, err
	}

	logger.Info("Retrieved movies", "count", len(response.Results), "page", page, "totalPages", response.TotalPages)
	posterSizes := configuration.Images.PosterSizes
	backdropSizes := configuration.Images.BackdropSizes

	for i, movie := range response.Results {
		logger.Debug("Processing movie", "number", i+1, "total", len(response.Results), "page", page)
		if err := processMovie(db, movie, configuration, posterSizes, backdropSizes, logger); err != nil {
			return false, err // Return error to stop processing
		}
	}

	logger.Info("Successfully processed page", "page", page, "movieCount", len(response.Results))
	return page >= response.TotalPages, nil
}

const HARD_MAX_PAGES = 500

func LoaderTmdbAPIDiscoverMovie(db *sql.DB, client *tmdbAPI.Client, maxPages int, done chan struct{}, logger *slog.Logger) error {
	maxPages = int(math.Min(float64(maxPages), float64(HARD_MAX_PAGES)))

	go func() {
		logger.Info("Starting TMDB Discover Movie loader worker")
		logger.Info("Processing pages", "maxPages", maxPages)

		configuration, err := client.Configuration()
		if err != nil {
			logger.Error("Failed to get configuration", "error", err)
			close(done)
			return
		}
		logger.Debug("Got TMDB configuration", "baseURL", configuration.Images.SecureBaseURL)
		logger.Debug("Image sizes", "posterSizes", configuration.Images.PosterSizes, "backdropSizes", configuration.Images.BackdropSizes)

		// Create rate limiter for 40 requests per 10 seconds (TMDB API limit)
		rateLimiter := time.NewTicker(250 * time.Millisecond)
		defer rateLimiter.Stop()

		for page := 1; page <= maxPages && page <= HARD_MAX_PAGES; page++ {
			<-rateLimiter.C // Wait for rate limiter before processing
			isLastPage, err := processMoviePage(db, client, page, configuration, logger)
			if err != nil {
				logger.Error("Stopping loader due to error", "error", err, "page", page)
				close(done)
				return
			}
			if isLastPage {
				logger.Info("Reached last page, media loader complete")
				break
			}
		}

		logger.Info("TMDB Discover Movie loader completed")
		close(done)
	}()

	return nil
}
