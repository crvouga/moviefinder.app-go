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
	"movieFinder/app/ui/caching"
	"movieFinder/app/ui/pages"
	"movieFinder/app/users"
	"movieFinder/app/users/auth"
	"movieFinder/lib/httpExt"
	"movieFinder/lib/sessionID"
	"movieFinder/lib/static"
	"movieFinder/lib/traceID"
	"net/http"
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

		if false {
			caching.No(w)
		} else {
			caching.Yes(w)
		}

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
