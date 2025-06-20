package mediaDB

import (
	"database/sql"
	"log/slog"
	"movieFinder/lib/tmdbAPI"
	"time"
)

type Worker struct {
	DB                    *sql.DB
	Client                *tmdbAPI.Client
	Logger                *slog.Logger
	DiscoverMovieMaxPages int
	DiscoverMovieThrottle time.Duration
	//
	insertMediaStmt      *InsertMedia
	insertMediaImageStmt *InsertMediaImage
	insertGenreStmt      *InsertGenre
	insertMediaGenreStmt *InsertMediaGenre
}

func NewWorker(db *sql.DB, client *tmdbAPI.Client, logger *slog.Logger) (*Worker, error) {
	insertMedia, err := NewInsertMedia(db)
	if err != nil {
		return nil, err
	}

	insertMediaImage, err := NewInsertMediaImage(db)
	if err != nil {
		insertMedia.Close()
		return nil, err
	}

	insertGenre, err := NewInsertGenre(db)
	if err != nil {
		insertMedia.Close()
		insertMediaImage.Close()
		return nil, err
	}

	insertMediaGenre, err := NewInsertMediaGenre(db)
	if err != nil {
		insertMedia.Close()
		insertMediaImage.Close()
		insertGenre.Close()
		return nil, err
	}

	return &Worker{
		DB:                    db,
		Client:                client,
		Logger:                logger,
		DiscoverMovieMaxPages: 500,
		DiscoverMovieThrottle: 20 * time.Second,
		insertMediaStmt:       insertMedia,
		insertMediaImageStmt:  insertMediaImage,
		insertGenreStmt:       insertGenre,
		insertMediaGenreStmt:  insertMediaGenre,
	}, nil
}

func (w *Worker) Close() error {
	var err error
	if w.insertMediaStmt != nil {
		if closeErr := w.insertMediaStmt.Close(); closeErr != nil {
			err = closeErr
		}
	}
	if w.insertMediaImageStmt != nil {
		if closeErr := w.insertMediaImageStmt.Close(); closeErr != nil {
			err = closeErr
		}
	}
	if w.insertGenreStmt != nil {
		if closeErr := w.insertGenreStmt.Close(); closeErr != nil {
			err = closeErr
		}
	}
	if w.insertMediaGenreStmt != nil {
		if closeErr := w.insertMediaGenreStmt.Close(); closeErr != nil {
			err = closeErr
		}
	}
	return err
}

func (w *Worker) Run() chan struct{} {
	w.Logger.Info("starting media worker")

	done := w.WorkerDiscoverMovieLoader()

	go func() {
		<-done
		w.Logger.Info("media worker completed successfully")
	}()

	return done
}
