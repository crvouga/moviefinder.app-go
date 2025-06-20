package feedPage

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/ctx/reqCtx"
	"movieFinder/app/feed"
	"net/http"
	"strconv"
)

func respondSlideChanged(ac *appCtx.AppCtx) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		ac.Logger.Debug("handling slide changed request")
		rc := reqCtx.FromHttpRequest(ac, r)

		feedIndex := r.URL.Query().Get("feedIndex")
		ac.Logger.Debug("got feedIndex from query", "feedIndex", feedIndex)

		if feedIndex == "" {
			ac.Logger.Error("Missing feedIndex parameter")
			http.Error(w, "feedIndex parameter is required", http.StatusBadRequest)
			return
		}

		feedIndexNew, err := strconv.ParseInt(feedIndex, 10, 64)
		ac.Logger.Debug("parsed feedIndex", "feedIndexNew", feedIndexNew)

		if err != nil {
			ac.Logger.Error("Error parsing feedIndex", "error", err)
			http.Error(w, "feedIndex must be a valid integer", http.StatusBadRequest)
			return
		}

		ac.Logger.Debug("getting feed for session", "sessionID", rc.SessionID.String())
		feedInst, err := feed.GetElseInsertBySessionID(ac.DB, rc.SessionID.String(), ac.Logger)

		if err != nil {
			ac.Logger.Error("Error getting feed", "error", err)
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		ac.Logger.Debug("updating feed index",
			"feedID", feedInst.ID,
			"oldIndex", feedInst.CurrentFeedIndex,
			"newIndex", feedIndexNew)
		feedInst.CurrentFeedIndex = feedIndexNew

		ac.Logger.Debug("upserting feed", "feedID", feedInst.ID)
		err = feed.UpsertFeed(ac.DB, *feedInst)

		if err != nil {
			ac.Logger.Error("Error updating feed", "error", err)
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		ac.Logger.Debug("slide changed request completed successfully")
		w.Header().Set("Content-Type", "text/plain")
		w.Write([]byte("ok"))
	}
}
