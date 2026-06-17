package postgres

import "testing"

func TestWithSchema_setsSearchPath(t *testing.T) {
	got, err := WithSchema("postgres://user:pass@localhost:5432/db?sslmode=disable")
	if err != nil {
		t.Fatal(err)
	}
	if got != "postgres://user:pass@localhost:5432/db?search_path=moviefinder_app_go&sslmode=disable" &&
		got != "postgres://user:pass@localhost:5432/db?sslmode=disable&search_path=moviefinder_app_go" {
		t.Fatalf("unexpected URL: %s", got)
	}
}

func TestSchemaName(t *testing.T) {
	if SchemaName != "moviefinder_app_go" {
		t.Fatalf("SchemaName = %q, want moviefinder_app_go", SchemaName)
	}
}
