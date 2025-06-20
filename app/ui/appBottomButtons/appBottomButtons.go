package appBottomButtons

import (
	"movieFinder/app/routes"
	"movieFinder/app/ui/bottomButtons"
	"movieFinder/app/ui/icons"
)

const (
	FeedPage    = "Home"
	AccountPage = "Account"
)

func AppBottomButtons(activePage string) bottomButtons.BottomButtons {
	return bottomButtons.BottomButtons{
		Items: []bottomButtons.BottomButtonsItem{
			{
				Label:    FeedPage,
				URL:      routes.FEED_PAGE,
				Active:   activePage == FeedPage,
				IconHTML: icons.HomeSolid(bottomButtons.IconSize),
			},
			{
				Label:    AccountPage,
				URL:      routes.USER_ACCOUNT,
				Active:   activePage == AccountPage,
				IconHTML: icons.UserSolid(bottomButtons.IconSize),
			},
		},
	}
}
