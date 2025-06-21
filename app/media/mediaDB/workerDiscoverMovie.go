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

	if err := w.insertMedia(tx, movie); err != nil {
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

func (w *Worker) insertMedia(tx *sql.Tx, movie tmdbAPI.DiscoverMovieResponseResult) error {
	mediaData := MediaData{
		ID:          movie.ID,
		Title:       movie.Title,
		Overview:    movie.Overview,
		Popularity:  movie.Popularity,
		ReleaseDate: movie.ReleaseDate,
		VoteAverage: movie.VoteAverage,
		VoteCount:   movie.VoteCount,
		Runtime:     0, // TODO: add this
		Adult:       movie.Adult,
	}
	if err := w.insertMediaStmt.Execute(tx, mediaData); err != nil {
		return err
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
		id := fmt.Sprintf("%d_poster_%d", movieID, i)
		mediaID := strconv.FormatInt(int64(movieID), 10)
		imageType := "poster"
		resolution := configuration.Images.PosterSizes[i]

		if err := w.insertMediaImageStmt.Execute(tx, id, mediaID, imageType, resolution, posterURL); err != nil {
			return err
		}

		w.Logger.Debug("Inserted poster image", "number", i+1, "total", len(posterURLs), "movieID", movieID)
	}
	return nil
}

func (w *Worker) insertBackdropImages(tx *sql.Tx, movieID int, backdropURLs []string, configuration *tmdbAPI.ConfigurationResponse) error {
	for i, backdropURL := range backdropURLs {
		id := fmt.Sprintf("%d_backdrop_%d", movieID, i)
		mediaID := strconv.FormatInt(int64(movieID), 10)
		imageType := "backdrop"
		resolution := configuration.Images.BackdropSizes[i]

		if err := w.insertMediaImageStmt.Execute(tx, id, mediaID, imageType, resolution, backdropURL); err != nil {
			return err
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
	return w.insertGenreStmt.Execute(tx, genreID)
}

func (w *Worker) insertMediaGenreRelation(tx *sql.Tx, movieID int, genreID int) error {
	return w.insertMediaGenreStmt.Execute(tx, movieID, genreID)
}

func (w *Worker) processMoviePage(configuration *tmdbAPI.ConfigurationResponse, page int) (bool, error) {
	w.Logger.Debug("Fetching page of movies from TMDB API", "page", page)

	response, err := w.Client.DiscoverMovie(tmdbAPI.DiscoverMovieParams{
		Page: page,
	})
	if err != nil {
		w.Logger.Error("Failed to get page", "page", page, "error", err)
		return false, err
	}

	w.Logger.Debug("Retrieved movies", "count", len(response.Results), "page", page, "totalPages", response.TotalPages)

	for i, movie := range response.Results {
		w.Logger.Debug("Processing movie", "number", i+1, "total", len(response.Results), "page", page)
		if err := w.processMovie(configuration, movie); err != nil {
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

func (w *Worker) processPages(logger *slog.Logger, configuration *tmdbAPI.ConfigurationResponse, page *int, done chan struct{}) {
	for *page = 1; *page <= w.DiscoverMovieMaxPages && *page <= HARD_MAX_PAGES; *page++ {
		time.Sleep(0 * time.Second)

		isLastPage, err := w.processMoviePage(configuration, *page)
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

func (w *Worker) getConfiguration(logger *slog.Logger) (*tmdbAPI.ConfigurationResponse, error) {
	configuration, err := w.Client.Configuration()
	if err != nil {
		return nil, err
	}

	logger.Debug("Got TMDB configuration", "baseURL", configuration.Images.SecureBaseURL)
	logger.Debug("Image sizes", "posterSizes", configuration.Images.PosterSizes, "backdropSizes", configuration.Images.BackdropSizes)

	return &configuration, nil
}

func (w *Worker) WorkerDiscoverMovieLoader() chan struct{} {
	logger := w.Logger.WithGroup("workerDiscoverMovie")
	done := make(chan struct{})
	page := 0

	go func() {
		logger.Info("Starting TMDB Discover Movie worker")
		logger.Info("Processing pages", "maxPages", w.DiscoverMovieMaxPages)

		configuration, err := w.getConfiguration(logger)
		if err != nil {
			logger.Error("Failed to get configuration", "error", err)
			close(done)
			return
		}

		w.processPages(logger, configuration, &page, done)
	}()

	w.startStatusTracker(logger, &page, done)

	return done
}
