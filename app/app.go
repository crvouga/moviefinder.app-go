package app

import (
	"movieFinder/app/admin"
	"movieFinder/app/api"
	"movieFinder/app/apiDocs"
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/ctx/reqCtx"
	"movieFinder/app/home"
	"movieFinder/app/home/homePage"
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
func Handler() http.Handler {
	ac := appCtx.New()

	mux := http.NewServeMux()

	router(mux, &ac)

	handler := traceID.WithTraceIDHeader(sessionID.WithSessionIDCookie(mux))
	handler = httpExt.GzipMiddleware(handler)

	return handler
}

// router is the router for the application.
func router(mux *http.ServeMux, ac *appCtx.AppCtx) {
	muxLoggedIn := newMuxLoggedIn(ac)
	muxLoggedOut := newMuxLoggedOut(ac)

	handler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		rc := reqCtx.FromHttpRequest(ac, r)
		rc.Logger.Info("request received", "path", r.URL.Path)

		setCacheControlHeaders(w, r)

		if err := static.ServeStaticAssets(w, r); err == nil {
			return
		}

		if auth.IsLoggedIn(ac, r) {
			muxLoggedIn.ServeHTTP(w, r)
			return
		}

		muxLoggedOut.ServeHTTP(w, r)
	})
	mux.Handle("/", handler)
}

func setCacheControlHeaders(w http.ResponseWriter, r *http.Request) {
	if r.URL.Query().Has("prefetch") {
		w.Header().Set("Cache-Control", "no-cache, no-store, must-revalidate")
		w.Header().Set("Pragma", "no-cache")
		w.Header().Set("Expires", "0")
		return
	}
	w.Header().Set("Cache-Control", "public, max-age=31536000, stale-while-revalidate=86400, stale-if-error=86400, immutable")
	w.Header().Set("Expires", time.Now().AddDate(1, 0, 0).Format(time.RFC1123))
}

// newMuxLoggedIn is the mux for the logged in user.
func newMuxLoggedIn(ac *appCtx.AppCtx) *http.ServeMux {
	mux := http.NewServeMux()
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
	return mux
}

// newMuxLoggedOut is the mux for the logged out user.
func newMuxLoggedOut(ac *appCtx.AppCtx) *http.ServeMux {
	mux := http.NewServeMux()
	users.RouterLoggedOut(mux, ac)
	api.Router(mux, ac)
	home.Router(mux, ac)
	pages.Router(mux)
	mux.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		homePage.Redirect(w, r)
	})
	return mux
}
