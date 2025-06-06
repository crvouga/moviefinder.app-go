package appBottomButtons

import (
	"movieFinder/app/routes"
	icons "movieFinder/app/ui"
	"movieFinder/app/ui/bottomButtons"
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
				URL:      routes.FeedPage,
				Active:   activePage == FeedPage,
				IconHTML: icons.HomeSolid(bottomButtons.IconSize),
			},
			{
				Label:    AccountPage,
				URL:      routes.UserAccountPage,
				Active:   activePage == AccountPage,
				IconHTML: icons.UserSolid(bottomButtons.IconSize),
			},
		},
	}
}
