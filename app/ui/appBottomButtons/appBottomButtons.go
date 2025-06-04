package appBottomButtons

import (
	"movieFinder/app/home/homeRoutes"
	"movieFinder/app/ui/bottomButtons"
	"movieFinder/app/users/userAccount/userAccountRoutes"
)

const (
	HomePage    = "Home"
	AccountPage = "Account"
)

func AppBottomButtons(activePage string) bottomButtons.BottomButtons {
	return bottomButtons.BottomButtons{
		Items: []bottomButtons.BottomButtonsItem{
			{
				Label:    HomePage,
				URL:      homeRoutes.HomePage,
				Active:   activePage == HomePage,
				IconHTML: "🏠",
			},
			{
				Label:    AccountPage,
				URL:      userAccountRoutes.UserAccountPage,
				Active:   activePage == AccountPage,
				IconHTML: "👤",
			},
		},
	}
}
