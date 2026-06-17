package postgres

// SchemaName is the dedicated Postgres schema for moviefinder.app-go (never public).
const SchemaName = "moviefinder_app_go"

// MigrationsTable is the fully-qualified dbmate migrations table in SchemaName.
func MigrationsTable() string {
	return SchemaName + ".schema_migrations"
}
