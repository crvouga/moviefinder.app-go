package appCtx

import (
	"database/sql"
	"log/slog"
	"movieFinder/app/appDB"
	"movieFinder/app/users/userAccount/userAccountDB"
	"movieFinder/app/users/userSession/userSessionDB"
	"movieFinder/lib/email/emailOutbox"
	"movieFinder/lib/keyValueDB"
	"movieFinder/lib/postgres"
	"movieFinder/lib/tmdbAPI"
	"movieFinder/lib/uow"
	"os"
)

type AppCtx struct {
	Postgres   *postgres.Postgres
	DB         *sql.DB
	DBDurable  *sql.DB
	TmdbClient *tmdbAPI.Client
	Logger     *slog.Logger
	UowFactory uow.UowFactory

	EmailOutbox   emailOutbox.EmailOutbox
	KeyValueDB    keyValueDB.KeyValueDB
	UserSessionDB userSessionDB.UserSessionDB
	UserAccountDB userAccountDB.UserAccountDB
}

func (ac *AppCtx) CleanUp() {
	ac.DB.Close()
}

func New() AppCtx {
	MAX_LOG_LEVEL := slog.LevelInfo
	logger := slog.New(slog.NewTextHandler(os.Stdout, &slog.HandlerOptions{Level: MAX_LOG_LEVEL})).WithGroup("app")

	postgres := appDB.New(logger)

	keyValueDBFs := keyValueDB.NewImplFs("keyValueDB.json")

	tmdbAPIClient, err := tmdbAPI.NewFromEnv(logger.WithGroup("tmdbAPI"))

	if err != nil {
		slog.Default().Error("Failed to create TMDB API client", "error", err)
	}

	if tmdbAPIClient == nil {
		panic("TMDB API client is required but was not initialized")
	}

	return AppCtx{
		Postgres:      postgres,
		DB:            postgres.DB,
		TmdbClient:    tmdbAPIClient,
		UowFactory:    *uow.NewFactory(postgres.DB),
		Logger:        logger.WithGroup("app"),
		KeyValueDB:    keyValueDB.NewImplNamespaced(keyValueDBFs, "app"),
		EmailOutbox:   emailOutbox.NewImplKeyValueDB(keyValueDBFs),
		UserSessionDB: userSessionDB.NewImplKeyValueDB(keyValueDBFs),
		UserAccountDB: userAccountDB.NewImplKeyValueDB(keyValueDBFs),
	}
}

func NewTest() AppCtx {
	logger := slog.Default().WithGroup("app")
	postgres := appDB.New(logger)
	keyValueDBHashMap := keyValueDB.ImplHashMap{}
	return AppCtx{
		Postgres:      postgres,
		DB:            postgres.DB,
		UowFactory:    *uow.NewFactory(postgres.DB),
		Logger:        logger,
		KeyValueDB:    &keyValueDBHashMap,
		EmailOutbox:   emailOutbox.NewImplKeyValueDB(&keyValueDBHashMap),
		UserSessionDB: userSessionDB.NewImplKeyValueDB(&keyValueDBHashMap),
		UserAccountDB: userAccountDB.NewImplKeyValueDB(&keyValueDBHashMap),
	}
}
