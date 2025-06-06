package app

import (
	"movieFinder/app/admin"
	"movieFinder/app/api"
	"movieFinder/app/apiDocs"
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/ctx/reqCtx"
	"movieFinder/app/home"
	"movieFinder/app/home/homePage"
	"movieFinder/app/media/mediaDB"
	"movieFinder/app/media/mediaPage"
	"movieFinder/app/projects"
	"movieFinder/app/ui/pages"
	"movieFinder/app/users"
	"movieFinder/app/users/auth"
	"movieFinder/lib/httpExt"
	"movieFinder/lib/sessionID"
	"movieFinder/lib/static"
	"movieFinder/lib/traceID"
	"net/http"
	"time"
)

// Handler is the main handler for the application.
func Handler(dbPath string) http.Handler {
	ac := appCtx.New(dbPath)
	ac.Logger.Debug("initializing application handler")

	ac.Logger.Debug("creating media tables")
	err := mediaDB.CreateTables(ac.DB, ac.Logger)
	if err != nil {
		ac.Logger.Error("failed to create media tables", "error", err)
		panic(err)
	}
	ac.Logger.Debug("starting tmdb api discover movie loader")

	ac.Logger.Debug("starting media loader")
	done := mediaDB.Loader(ac.DB, ac.TmdbAPIClient, ac.Logger)
	go func() {
		<-done
		ac.Logger.Debug("media loader completed")
	}()

	mux := http.NewServeMux()

	ac.Logger.Debug("setting up router")
	router(mux, &ac)

	handler := traceID.WithTraceIDHeader(sessionID.WithSessionIDCookie(mux))
	handler = httpExt.GzipMiddleware(handler)
	ac.Logger.Debug("handler setup complete")

	return handler
}

// router is the router for the application.
func router(mux *http.ServeMux, ac *appCtx.AppCtx) {
	ac.Logger.Debug("initializing routers")
	muxLoggedIn := newMuxLoggedIn(ac)
	muxLoggedOut := newMuxLoggedOut(ac)

	handler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		rc := reqCtx.FromHttpRequest(ac, r)
		rc.Logger.Debug("request received", "path", r.URL.Path)

		setCacheControlHeaders(w, r)

		if err := static.ServeStaticAssets(w, r, "public"); err == nil {
			rc.Logger.Debug("served static asset", "path", r.URL.Path)
			return
		}

		if auth.IsLoggedIn(ac, r) {
			rc.Logger.Debug("routing to logged in handler", "path", r.URL.Path)
			muxLoggedIn.ServeHTTP(w, r)
			return
		}

		rc.Logger.Debug("routing to logged out handler", "path", r.URL.Path)
		muxLoggedOut.ServeHTTP(w, r)
	})
	mux.Handle("/", handler)
	ac.Logger.Debug("router setup complete")
}

func setCacheControlHeaders(w http.ResponseWriter, r *http.Request) {
	if r.URL.Query().Has("no-cache") || true {
		w.Header().Set("Cache-Control", "no-cache, no-store, must-revalidate")
		w.Header().Set("Pragma", "no-cache")
		w.Header().Set("Expires", "0")
		return
	}
	w.Header().Set("Cache-Control", "public, max-age=0, must-revalidate, stale-while-revalidate=86400")
	w.Header().Set("Expires", time.Now().Format(time.RFC1123))
}

// newMuxLoggedIn is the mux for the logged in user.
func newMuxLoggedIn(ac *appCtx.AppCtx) *http.ServeMux {
	ac.Logger.Debug("setting up logged in router")
	mux := http.NewServeMux()
	mediaPage.Router(mux, ac)
	users.Router(mux, ac)
	home.Router(mux, ac)
	projects.Router(mux, ac)
	apiDocs.Router(mux, ac)
	pages.Router(mux)
	admin.Router(mux, ac)
	api.Router(mux, ac)
	mux.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		homePage.Redirect(w, r)
	})
	ac.Logger.Debug("logged in router setup complete")
	return mux
}

// newMuxLoggedOut is the mux for the logged out user.
func newMuxLoggedOut(ac *appCtx.AppCtx) *http.ServeMux {
	ac.Logger.Debug("setting up logged out router")
	mux := http.NewServeMux()
	users.RouterLoggedOut(mux, ac)
	mediaPage.Router(mux, ac)
	api.Router(mux, ac)
	home.Router(mux, ac)
	pages.Router(mux)
	mux.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		homePage.Redirect(w, r)
	})
	ac.Logger.Debug("logged out router setup complete")
	return mux
}
