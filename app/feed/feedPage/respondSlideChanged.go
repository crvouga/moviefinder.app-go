package feedPage

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/ctx/reqCtx"
	"movieFinder/app/feed/feedDB"
	"net/http"
	"strconv"
)

func respondSlideChanged(ac *appCtx.AppCtx) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		rc := reqCtx.FromHttpRequest(ac, r)
		rc.Logger.Debug("handling slide changed request")

		feedIndex := r.URL.Query().Get("feedIndex")
		rc.Logger.Debug("got feedIndex from query", "feedIndex", feedIndex)

		if feedIndex == "" {
			rc.Logger.Error("Missing feedIndex parameter")
			http.Error(w, "feedIndex parameter is required", http.StatusBadRequest)
			return
		}

		feedIndexNew, err := strconv.ParseInt(feedIndex, 10, 64)
		rc.Logger.Debug("parsed feedIndex", "feedIndexNew", feedIndexNew)

		if err != nil {
			rc.Logger.Error("Error parsing feedIndex", "error", err)
			http.Error(w, "feedIndex must be a valid integer", http.StatusBadRequest)
			return
		}

		rc.Logger.Debug("getting feed for session", "sessionID", rc.SessionID.String())
		feed_, err := feedDB.GetElseInsertBySessionID(ac.DB, rc.SessionID.String(), rc.Logger)

		if err != nil {
			rc.Logger.Error("Error getting feed", "error", err)
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		rc.Logger.Debug("updating feed index",
			"feedID", feed_.ID,
			"oldIndex", feed_.CurrentFeedIndex,
			"newIndex", feedIndexNew)

		feed_.CurrentFeedIndex = feedIndexNew

		rc.Logger.Debug("upserting feed", "feedID", feed_.ID)

		err = feedDB.UpsertFeed(ac.DB, *feed_)

		if err != nil {
			rc.Logger.Error("Error updating feed", "error", err)
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		rc.Logger.Debug("slide changed request completed successfully")
		w.Header().Set("Content-Type", "text/plain")
		w.Write([]byte("ok"))
	}
}
