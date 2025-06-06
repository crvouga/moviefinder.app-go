package appCtx

import (
	"database/sql"

	"log/slog"
	"movieFinder/app/projects/project/projectDB"
	"movieFinder/app/users/login/link/linkDB"
	"movieFinder/app/users/userAccount/userAccountDB"
	"movieFinder/app/users/userSession/userSessionDB"
	"movieFinder/lib/email/emailOutbox"
	"movieFinder/lib/keyValueDB"
	"movieFinder/lib/sqlite"
	"movieFinder/lib/tmdbAPI"
	"movieFinder/lib/uow"
)

type AppCtx struct {
	DB            *sql.DB
	TmdbAPIClient *tmdbAPI.Client
	Logger        *slog.Logger
	UowFactory    uow.UowFactory
	LinkDB        linkDB.LinkDB
	EmailOutbox   emailOutbox.EmailOutbox
	KeyValueDB    keyValueDB.KeyValueDB
	UserSessionDB userSessionDB.UserSessionDB
	UserAccountDB userAccountDB.UserAccountDB
	ProjectDB     projectDB.ProjectDB
}

func (ac *AppCtx) CleanUp() {
	ac.DB.Close()
}

func New() AppCtx {
	db, err := sqlite.New(":memory:")
	if err != nil {
		panic(err)
	}

	keyValueDBFs := keyValueDB.NewImplFs("keyValueDB.json")

	tmdbAPIClient, err := tmdbAPI.NewFromEnv(slog.Default())
	if err != nil {
		slog.Default().Error("Failed to create TMDB API client", "error", err)
	}

	if tmdbAPIClient == nil {
		panic("TMDB API client is required but was not initialized")
	}

	return AppCtx{
		DB:            db,
		TmdbAPIClient: tmdbAPIClient,
		UowFactory:    *uow.NewFactory(db),
		Logger:        slog.Default(),
		KeyValueDB:    keyValueDB.NewImplNamespaced(keyValueDBFs, "app"),
		LinkDB:        linkDB.NewImplKeyValueDB(keyValueDBFs),
		EmailOutbox:   emailOutbox.NewImplKeyValueDB(keyValueDBFs),
		UserSessionDB: userSessionDB.NewImplKeyValueDB(keyValueDBFs),
		UserAccountDB: userAccountDB.NewImplKeyValueDB(keyValueDBFs),
		ProjectDB:     projectDB.NewImplKeyValueDB(keyValueDBFs),
	}
}

func NewTest() AppCtx {
	db, err := sqlite.New(":memory:")
	if err != nil {
		panic(err)
	}

	keyValueDBHashMap := keyValueDB.ImplHashMap{}

	return AppCtx{
		DB:            db,
		UowFactory:    *uow.NewFactory(db),
		Logger:        slog.Default(),
		KeyValueDB:    &keyValueDBHashMap,
		LinkDB:        linkDB.NewImplKeyValueDB(&keyValueDBHashMap),
		EmailOutbox:   emailOutbox.NewImplKeyValueDB(&keyValueDBHashMap),
		UserSessionDB: userSessionDB.NewImplKeyValueDB(&keyValueDBHashMap),
		UserAccountDB: userAccountDB.NewImplKeyValueDB(&keyValueDBHashMap),
		ProjectDB:     projectDB.NewImplKeyValueDB(&keyValueDBHashMap),
	}
}
