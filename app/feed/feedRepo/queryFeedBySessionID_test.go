package feedRepo

import (
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/feed"
	"testing"
)

func TestQueryFeedBySessionID(t *testing.T) {

	ctx := appCtx.NewTest()
	defer ctx.DB.Close()

	// Create a test feed and session mapping
	feed := feed.Feed{
		ID:               "test-feed-123",
		CurrentFeedIndex: 0,
		CreatedAtEpoch:   1234567890,
		UpdatedAtEpoch:   1234567890,
	}

	// Insert test feed
	err := UpsertFeed(ctx.DB, feed)
	if err != nil {
		t.Fatalf("Failed to insert test feed: %v", err)
	}

	// Create test session mapping
	testSessionID := "test-session-123"
	err = UpsertFeedSessionMapping(ctx.DB, feed.ID, testSessionID)
	if err != nil {
		t.Fatalf("Failed to insert test session mapping: %v", err)
	}

	// Test querying for the feed by session ID
	retrievedFeed, err := QueryFeedBySessionID(ctx.DB, testSessionID, ctx.Logger)
	if err != nil {
		t.Errorf("Expected no error querying feed by session ID, got %v", err)
	}

	// Verify the feed fields
	if retrievedFeed.ID != feed.ID {
		t.Errorf("Expected ID %s, got %s", feed.ID, retrievedFeed.ID)
	}
	if retrievedFeed.CurrentFeedIndex != feed.CurrentFeedIndex {
		t.Errorf("Expected CurrentFeedIndex %d, got %d", feed.CurrentFeedIndex, retrievedFeed.CurrentFeedIndex)
	}
	if retrievedFeed.CreatedAtEpoch != feed.CreatedAtEpoch {
		t.Errorf("Expected CreatedAtEpoch %d, got %d", feed.CreatedAtEpoch, retrievedFeed.CreatedAtEpoch)
	}
	if retrievedFeed.UpdatedAtEpoch != feed.UpdatedAtEpoch {
		t.Errorf("Expected UpdatedAtEpoch %d, got %d", feed.UpdatedAtEpoch, retrievedFeed.UpdatedAtEpoch)
	}

	// Test querying for non-existent session ID
	_, err = QueryFeedBySessionID(ctx.DB, "non-existent-session", ctx.Logger)
	if err == nil {
		t.Error("Expected error querying non-existent session ID, got nil")
	}
}
