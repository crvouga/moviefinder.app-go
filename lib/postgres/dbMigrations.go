package postgres

import (
	"embed"
	"net/url"

	"github.com/amacneil/dbmate/v2/pkg/dbmate"
	_ "github.com/amacneil/dbmate/v2/pkg/driver/postgres"
)

func (p *Postgres) MigrateUp(migrationsFS embed.FS, migrationsDir string) error {
	p.Logger.Info("Migrating up")
	u, err := url.Parse(p.DatabaseURL)

	if err != nil {
		p.Logger.Error("Failed to parse database URL", "error", err)
		return err
	}

	p.Logger.Info("Creating database connection")
	db := dbmate.New(u)
	db.FS = migrationsFS
	db.MigrationsDir = []string{migrationsDir}

	p.Logger.Info("Running database migrations")
	err = db.CreateAndMigrate()
	if err != nil {
		p.Logger.Error("Failed to run migrations", "error", err)
		return err
	}

	p.Logger.Info("Successfully completed migrations")
	return nil
}
