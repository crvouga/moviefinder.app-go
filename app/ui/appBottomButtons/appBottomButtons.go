package appBottomButtons

import (
	"movieFinder/app/home/homeRoutes"
	icons "movieFinder/app/ui"
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
				IconHTML: icons.HomeSolid(bottomButtons.IconSize),
			},
			{
				Label:    AccountPage,
				URL:      userAccountRoutes.UserAccountPage,
				Active:   activePage == AccountPage,
				IconHTML: icons.UserSolid(bottomButtons.IconSize),
			},
		},
	}
}
