package feedPage

import (
	"movieFinder/app/ctx/appCtx"
	"net/http"
)

func respondSlideChanged(ac *appCtx.AppCtx) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		feedIndexNew := r.URL.Query().Get("feedIndex")
		ac.Logger.Info("Slide changed", "index", feedIndexNew)
		ac.DB.Exec("UPDATE feed SET current_feed_index = ?", feedIndexNew)
		w.WriteHeader(http.StatusOK)
	}
}
