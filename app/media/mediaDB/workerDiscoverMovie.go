package mediaDB

import (
	"database/sql"
	"fmt"
	"movieFinder/lib/tmdbAPI"
	"strconv"
	"time"
)

const HARD_MAX_PAGES = 500

func (w *Worker) processMovie(configuration *tmdbAPI.ConfigurationResponse, movie tmdbAPI.DiscoverMovieResponseResult) error {
	w.Logger.Debug("Processing movie", "title", movie.Title, "id", movie.ID)
	w.Logger.Debug("Movie details", "title", movie.Title, "popularity", movie.Popularity, "releaseDate", movie.ReleaseDate)

	posterURLs := tmdbAPI.ToPosterURLs(movie.PosterPath, *configuration, configuration.Images.PosterSizes)
	backdropURLs := tmdbAPI.ToBackdropURLs(movie.BackdropPath, *configuration, configuration.Images.BackdropSizes)

	w.Logger.Debug("Generated URLs", "posterCount", len(posterURLs), "backdropCount", len(backdropURLs))

	tx, err := w.beginTransaction()
	if err != nil {
		return err
	}
	defer tx.Rollback()

	if err := w.insertMovieBase(tx, movie); err != nil {
		return err
	}

	if err := w.insertMovieImages(tx, movie.ID, posterURLs, backdropURLs, configuration); err != nil {
		return err
	}

	if err := w.insertMovieGenres(tx, movie.ID, movie.GenreIds); err != nil {
		return err
	}

	if err := tx.Commit(); err != nil {
		return fmt.Errorf("failed to commit transaction: %v", err)
	}

	w.Logger.Debug("Successfully completed database transaction", "movieID", movie.ID)
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

func (w *Worker) insertMovieBase(tx *sql.Tx, movie tmdbAPI.DiscoverMovieResponseResult) error {
	_, err := tx.Exec(`
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

	w.Logger.Debug("Inserted base movie data", "movieID", movie.ID)
	return nil
}

func (w *Worker) insertMovieImages(tx *sql.Tx, movieID int, posterURLs []string, backdropURLs []string, configuration *tmdbAPI.ConfigurationResponse) error {
	if err := w.insertPosterImages(tx, movieID, posterURLs, configuration); err != nil {
		return err
	}

	if err := w.insertBackdropImages(tx, movieID, backdropURLs, configuration); err != nil {
		return err
	}

	return nil
}

func (w *Worker) insertPosterImages(tx *sql.Tx, movieID int, posterURLs []string, configuration *tmdbAPI.ConfigurationResponse) error {
	for i, posterURL := range posterURLs {
		_, err := tx.Exec(`
			INSERT OR REPLACE INTO media_images (
				id,
				media_id,
				image_type,
				resolution,
				url
			) VALUES (?, ?, ?, ?, ?)`,
			fmt.Sprintf("%d_poster_%d", movieID, i),
			strconv.FormatInt(int64(movieID), 10),
			"poster",
			configuration.Images.PosterSizes[i],
			posterURL,
		)
		if err != nil {
			return fmt.Errorf("failed to insert poster image: %v", err)
		}
		w.Logger.Debug("Inserted poster image", "number", i+1, "total", len(posterURLs), "movieID", movieID)
	}
	return nil
}

func (w *Worker) insertBackdropImages(tx *sql.Tx, movieID int, backdropURLs []string, configuration *tmdbAPI.ConfigurationResponse) error {
	for i, backdropURL := range backdropURLs {
		_, err := tx.Exec(`
			INSERT OR REPLACE INTO media_images (
				id,
				media_id,
				image_type,
				resolution,
				url
			) VALUES (?, ?, ?, ?, ?)`,
			fmt.Sprintf("%d_backdrop_%d", movieID, i),
			strconv.FormatInt(int64(movieID), 10),
			"backdrop",
			configuration.Images.BackdropSizes[i],
			backdropURL,
		)
		if err != nil {
			return fmt.Errorf("failed to insert backdrop image: %v", err)
		}
		w.Logger.Debug("Inserted backdrop image", "number", i+1, "total", len(backdropURLs), "movieID", movieID)
	}
	return nil
}

func (w *Worker) insertMovieGenres(tx *sql.Tx, movieID int, genreIDs []int) error {
	w.Logger.Debug("Processing genres", "count", len(genreIDs), "movieID", movieID)

	for i, genreID := range genreIDs {
		if err := w.insertGenre(tx, genreID); err != nil {
			return err
		}

		if err := w.insertMediaGenreRelation(tx, movieID, genreID); err != nil {
			return err
		}

		w.Logger.Debug("Processed genre", "number", i+1, "total", len(genreIDs), "genreID", genreID, "movieID", movieID)
	}
	return nil
}

func (w *Worker) insertGenre(tx *sql.Tx, genreID int) error {
	_, err := tx.Exec(`
		INSERT OR IGNORE INTO genres (id, name) VALUES (?, ?)`,
		strconv.FormatInt(int64(genreID), 10),
		"", // Name will be updated later when we have genre details
	)
	if err != nil {
		return fmt.Errorf("failed to insert genre: %v", err)
	}
	return nil
}

func (w *Worker) insertMediaGenreRelation(tx *sql.Tx, movieID int, genreID int) error {
	_, err := tx.Exec(`
		INSERT OR IGNORE INTO media_genres (media_id, genre_id) VALUES (?, ?)`,
		strconv.FormatInt(int64(movieID), 10),
		strconv.FormatInt(int64(genreID), 10),
	)
	if err != nil {
		return fmt.Errorf("failed to insert media_genre: %v", err)
	}
	return nil
}

func (w *Worker) processMoviePage(configuration *tmdbAPI.ConfigurationResponse, page int) (bool, error) {
	w.Logger.Info("Fetching page of movies from TMDB API", "page", page)

	response, err := w.Client.DiscoverMovie(tmdbAPI.DiscoverMovieParams{
		Page: page,
	})
	if err != nil {
		w.Logger.Error("Failed to get page", "page", page, "error", err)
		return false, err
	}

	w.Logger.Info("Retrieved movies", "count", len(response.Results), "page", page, "totalPages", response.TotalPages)

	for i, movie := range response.Results {
		w.Logger.Debug("Processing movie", "number", i+1, "total", len(response.Results), "page", page)
		if err := w.processMovie(configuration, movie); err != nil {
			return false, err // Return error to stop processing
		}
	}

	w.Logger.Info("Successfully processed page", "page", page, "movieCount", len(response.Results))
	return page >= response.TotalPages, nil
}

func (w *Worker) WorkerDiscoverMovieLoader() chan struct{} {

	done := make(chan struct{})

	go func() {
		w.Logger.Info("Starting TMDB Discover Movie worker")
		w.Logger.Info("Processing pages", "maxPages", w.DiscoverMovieMaxPages)

		configuration, err := w.Client.Configuration()
		if err != nil {
			w.Logger.Error("Failed to get configuration", "error", err)
			close(done)
			return
		}

		w.Logger.Debug("Got TMDB configuration", "baseURL", configuration.Images.SecureBaseURL)
		w.Logger.Debug("Image sizes", "posterSizes", configuration.Images.PosterSizes, "backdropSizes", configuration.Images.BackdropSizes)

		// Process pages sequentially
		for page := 1; page <= w.DiscoverMovieMaxPages && page <= HARD_MAX_PAGES; page++ {
			// Rate limit to 1 request per second
			time.Sleep(w.DiscoverMovieThrottle)

			isLastPage, err := w.processMoviePage(&configuration, page)
			if err != nil {
				w.Logger.Error("Failed to process page", "page", page, "error", err)
				close(done)
				return
			}

			if isLastPage {
				w.Logger.Info("Reached last page, media worker complete")
				close(done)
				return
			}
		}

		w.Logger.Info("TMDB Discover Movie worker completed")
		close(done)
	}()

	return done
}
