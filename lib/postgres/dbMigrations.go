package postgres

import (
	"embed"
	"net/url"

	"github.com/amacneil/dbmate/v2/pkg/dbmate"
	_ "github.com/amacneil/dbmate/v2/pkg/driver/postgres"
)

func (p *Postgres) MigrateUp(migrationsFS embed.FS, migrationsDir string) error {
	p.Logger.Info("Migrating up", "schema", SchemaName)

	if err := EnsureSchema(p.DB); err != nil {
		p.Logger.Error("Failed to ensure schema", "error", err)
		return err
	}

	if err := BootstrapFromPublic(p.DB, p.Logger); err != nil {
		p.Logger.Error("Failed to bootstrap legacy public schema", "error", err)
		return err
	}

	schemaURL, err := WithSchema(p.DatabaseURL)
	if err != nil {
		p.Logger.Error("Failed to parse database URL", "error", err)
		return err
	}

	u, err := url.Parse(schemaURL)
	if err != nil {
		p.Logger.Error("Failed to parse schema database URL", "error", err)
		return err
	}

	db := dbmate.New(u)
	db.FS = migrationsFS
	db.MigrationsDir = []string{migrationsDir}

	p.Logger.Info("Running database migrations", "schema", SchemaName)
	if err := db.CreateAndMigrate(); err != nil {
		p.Logger.Error("Failed to run migrations", "error", err)
		return err
	}

	p.Logger.Info("Successfully completed migrations", "schema", SchemaName)
	return nil
}
