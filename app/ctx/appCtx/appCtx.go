package appCtx

import (
	"database/sql"
	"log/slog"
	"movieFinder/app/appDb"
	"movieFinder/app/users/userAccount/userAccountDB"
	"movieFinder/app/users/userSession/userSessionDB"
	"movieFinder/lib/email/emailOutbox"
	"movieFinder/lib/keyValueDB"
	"movieFinder/lib/sqlite"
	"movieFinder/lib/tmdbAPI"
	"movieFinder/lib/uow"
	"os"
)

type AppCtx struct {
	DB            *sql.DB
	DBDurable     *sql.DB
	TmdbAPIClient *tmdbAPI.Client
	Logger        *slog.Logger
	UowFactory    uow.UowFactory

	EmailOutbox   emailOutbox.EmailOutbox
	KeyValueDB    keyValueDB.KeyValueDB
	UserSessionDB userSessionDB.UserSessionDB
	UserAccountDB userAccountDB.UserAccountDB
}

func (ac *AppCtx) CleanUp() {
	ac.DB.Close()
}

func New() AppCtx {
	dbDurable := appDb.OpenDurable()
	db := appDb.OpenInMemory()

	keyValueDBFs := keyValueDB.NewImplFs("keyValueDB.json")

	MAX_LOG_LEVEL := slog.LevelInfo

	logger := slog.New(slog.NewTextHandler(os.Stdout, &slog.HandlerOptions{Level: MAX_LOG_LEVEL})).WithGroup("app")

	tmdbAPIClient, err := tmdbAPI.NewFromEnv(logger.WithGroup("tmdbAPI"))

	if err != nil {
		slog.Default().Error("Failed to create TMDB API client", "error", err)
	}

	if tmdbAPIClient == nil {
		panic("TMDB API client is required but was not initialized")
	}

	return AppCtx{
		DB:            db,
		DBDurable:     dbDurable,
		TmdbAPIClient: tmdbAPIClient,
		UowFactory:    *uow.NewFactory(db),
		Logger:        logger,
		KeyValueDB:    keyValueDB.NewImplNamespaced(keyValueDBFs, "app"),

		EmailOutbox:   emailOutbox.NewImplKeyValueDB(keyValueDBFs),
		UserSessionDB: userSessionDB.NewImplKeyValueDB(keyValueDBFs),
		UserAccountDB: userAccountDB.NewImplKeyValueDB(keyValueDBFs),
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
		EmailOutbox:   emailOutbox.NewImplKeyValueDB(&keyValueDBHashMap),
		UserSessionDB: userSessionDB.NewImplKeyValueDB(&keyValueDBHashMap),
		UserAccountDB: userAccountDB.NewImplKeyValueDB(&keyValueDBHashMap),
	}
}
