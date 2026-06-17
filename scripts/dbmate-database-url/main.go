package main

import (
	"fmt"
	"os"

	"movieFinder/lib/postgres"
)

func main() {
	raw := os.Getenv("DATABASE_URL")
	if raw == "" {
		fmt.Fprintln(os.Stderr, "DATABASE_URL required")
		os.Exit(1)
	}

	out, err := postgres.WithSchema(raw)
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}

	fmt.Print(out)
}
