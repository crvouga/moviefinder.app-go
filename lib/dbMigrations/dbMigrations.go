package dbMigrations

import (
	"embed"
	"fmt"
	"log"
	"net/url"

	"github.com/amacneil/dbmate/v2/pkg/dbmate"
	_ "github.com/amacneil/dbmate/v2/pkg/driver/sqlite"
)

func Run(migrationFiles embed.FS) {
	log.Println("Running migrations")

	u, _ := url.Parse("sqlite:db/db.sqlite")
	db := dbmate.New(u)
	db.FS = migrationFiles

	fmt.Println("Migrations:")
	migrations, err := db.FindMigrations()
	if err != nil {
		panic(err)
	}
	for _, m := range migrations {
		fmt.Println(m.Version, m.FilePath)
	}

	fmt.Println("\nApplying...")
	err = db.CreateAndMigrate()
	if err != nil {
		panic(err)
	}

	log.Println("Migrations complete")
}
