package db

import "embed"

//go:embed schema.sql
var SchemaFs embed.FS

//go:embed migrations/*.sql
var MigrationsFs embed.FS

const MigrationsDir = "migrations"
