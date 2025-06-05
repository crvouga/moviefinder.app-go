package mediaDB

import (
	"database/sql"
	"movieFinder/lib/sqlite"
	"testing"
)

func TestCreateTable(t *testing.T) {
	// Open an in-memory SQLite database
	db, err := sqlite.New(":memory:")
	if err != nil {
		t.Fatalf("Failed to open database: %v", err)
	}
	defer db.Close()

	// Create the tables
	CreateTable(db)

	// Verify tables were created by checking their existence
	tables := []string{"media", "media_images", "genres", "media_genres"}

	for _, table := range tables {
		var name string
		err := db.QueryRow(`
			SELECT name FROM sqlite_master 
			WHERE type='table' AND name=?`, table).Scan(&name)

		if err == sql.ErrNoRows {
			t.Errorf("Table %s was not created", table)
		} else if err != nil {
			t.Errorf("Error checking table %s: %v", table, err)
		}
	}

	// Verify foreign key constraints exist
	constraints := []struct {
		table    string
		expected int
	}{
		{"media_images", 1}, // One foreign key to media
		{"media_genres", 2}, // Two foreign keys: to media and genres
	}

	for _, c := range constraints {
		var count int
		err := db.QueryRow(`
			SELECT COUNT(*) FROM pragma_foreign_key_list(?)`, c.table).Scan(&count)

		if err != nil {
			t.Errorf("Error checking foreign keys for %s: %v", c.table, err)
		}
		if count != c.expected {
			t.Errorf("Table %s: expected %d foreign key(s), got %d", c.table, c.expected, count)
		}
	}
}
