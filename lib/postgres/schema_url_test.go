package postgres

import (
	"net/url"
	"strings"
	"testing"
)

func TestWithSchema_setsSearchPath(t *testing.T) {
	got, err := WithSchema("postgres://user:pass@localhost:5432/db?sslmode=disable")
	if err != nil {
		t.Fatal(err)
	}
	u, err := url.Parse(got)
	if err != nil {
		t.Fatal(err)
	}
	q := u.Query()
	if q.Get("search_path") != SchemaName {
		t.Fatalf("search_path = %q, want %q", q.Get("search_path"), SchemaName)
	}
	if !strings.Contains(q.Get("options"), "-csearch_path="+SchemaName) {
		t.Fatalf("options = %q, want search_path in options", q.Get("options"))
	}
}

func TestSchemaName(t *testing.T) {
	if SchemaName != "moviefinder_app_go" {
		t.Fatalf("SchemaName = %q, want moviefinder_app_go", SchemaName)
	}
	if MigrationsTable() != "moviefinder_app_go.schema_migrations" {
		t.Fatalf("MigrationsTable() = %q", MigrationsTable())
	}
}
