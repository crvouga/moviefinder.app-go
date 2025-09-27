package mediaDB

import (
	"database/sql"
	"movieFinder/app/media"
)

type MediaDB struct {
	QueryMediaByID    *QueryMediaByID
	QueryPopularMedia *QueryPopularMedia
}

func New(db *sql.DB) (*MediaDB, error) {
	queryMediaByID, err := NewQueryMediaByID(db)
	if err != nil {
		return nil, err
	}

	queryPopularMedia, err := NewQueryPopularMedia(db)
	if err != nil {
		return nil, err
	}

	return &MediaDB{
		QueryMediaByID:    queryMediaByID,
		QueryPopularMedia: queryPopularMedia,
	}, nil
}

func (m *MediaDB) Close() error {
	if err := m.QueryMediaByID.Close(); err != nil {
		return err
	}
	if err := m.QueryPopularMedia.Close(); err != nil {
		return err
	}
	return nil
}

func (m *MediaDB) QueryPopular(limit int, offset int) ([]media.Media, error) {
	return m.QueryPopularMedia.Query(limit, offset)
}

func (m *MediaDB) QueryByID(id string) (*media.Media, error) {
	return m.QueryMediaByID.Query(id)
}
