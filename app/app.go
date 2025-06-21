package app

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/ctx/reqCtx"
	"movieFinder/app/feed/feedPage"
	"movieFinder/app/media/mediaPage"
	"movieFinder/app/ui/pages"
	"movieFinder/app/users"
	"movieFinder/app/users/auth"
	"movieFinder/lib/httpExt"
	"movieFinder/lib/sessionID"
	"movieFinder/lib/static"
	"movieFinder/lib/traceID"
	"net/http"
	"strings"
	"time"
)

// Handler is the main handler for the application.
func Handler() http.Handler {
	ac := appCtx.New()
	ac.Logger.Debug("initializing application handler")

	worker := Worker{
		DB:         ac.DB,
		TmdbClient: ac.TmdbClient,
		Logger:     ac.Logger,
	}
	done, err := worker.Run()
	if err != nil {
		ac.Logger.Error("Failed to start worker", "error", err)
		// Continue without worker - the application can still serve requests
	} else {
		go func() {
			<-done
			ac.Logger.Debug("worker completed")
		}()
	}

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
		rc.Logger.Info("request received",
			"method", r.Method,
			"path", r.URL.Path)

		if err := static.ServeStaticAssets(w, r, "public"); err == nil {

			rc.Logger.Debug("served static asset", "path", r.URL.Path)
			return
		}

		setCacheControlHeaders(w, r)

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
	if strings.HasSuffix(r.URL.Path, ".css") {
		setCacheHeaders(w)
		return
	}

	setNoCacheHeaders(w)
}

func setNoCacheHeaders(w http.ResponseWriter) {
	w.Header().Set("Cache-Control", "no-cache, no-store, must-revalidate")
	w.Header().Set("Pragma", "no-cache")
	w.Header().Set("Expires", "0")
}

func setCacheHeaders(w http.ResponseWriter) {
	w.Header().Set("Cache-Control", "public, max-age=31919000")
	w.Header().Set("Expires", time.Now().Add(24*time.Hour).Format(time.RFC1123))
}

// newMuxLoggedIn is the mux for the logged in user.
func newMuxLoggedIn(ac *appCtx.AppCtx) *http.ServeMux {
	ac.Logger.Debug("setting up logged in router")
	mux := http.NewServeMux()
	mediaPage.Router(mux, ac)
	users.Router(mux, ac)
	feedPage.Router(mux, ac)
	pages.Router(mux)
	mux.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		feedPage.Redirect(w, r)
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
	feedPage.Router(mux, ac)
	pages.Router(mux)
	mux.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		feedPage.Redirect(w, r)
	})
	ac.Logger.Debug("logged out router setup complete")
	return mux
}
