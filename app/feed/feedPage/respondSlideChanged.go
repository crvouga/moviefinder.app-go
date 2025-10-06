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
		logger := rc.Logger
		logger.Debug("handling slide changed request")

		// Get and validate feed index from query params
		feedIndex := r.URL.Query().Get("feedIndex")
		logger.Debug("got feedIndex from query", "feedIndex", feedIndex)

		if feedIndex == "" {
			logger.Error("Missing feedIndex parameter")
			http.Error(w, "feedIndex parameter is required", http.StatusBadRequest)
			return
		}

		// Parse feed index to integer
		feedIndexNew, err := strconv.ParseInt(feedIndex, 10, 64)
		logger.Debug("parsed feedIndex", "feedIndexNew", feedIndexNew)

		if err != nil {
			logger.Error("Error parsing feedIndex", "error", err)
			http.Error(w, "feedIndex must be a valid integer", http.StatusBadRequest)
			return
		}

		// Get or create feed for session
		logger.Debug("getting feed for session", "sessionID", rc.SessionID.String())
		feed, err := feedDB.GetElseInsertBySessionID(ac.DB, rc.SessionID.String(), logger)

		if err != nil {
			logger.Error("Error getting feed", "error", err)
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		// Update feed index
		logger.Debug("updating feed index",
			"feedID", feed.ID,
			"oldIndex", feed.CurrentFeedIndex,
			"newIndex", feedIndexNew)

		feed.CurrentFeedIndex = feedIndexNew

		// Save updated feed
		logger.Debug("upserting feed", "feedID", feed.ID)
		err = feedDB.UpsertFeed(ac.DB, *feed)

		if err != nil {
			logger.Error("Error updating feed", "error", err)
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		// Return success response
		logger.Debug("slide changed request completed successfully")
		w.Header().Set("Content-Type", "text/plain")
		w.Write([]byte("ok"))
	}
}
