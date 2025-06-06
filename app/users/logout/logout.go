package logout

import (
	"errors"
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/ctx/reqCtx"
	"movieFinder/app/home/homeRoutes"
	"movieFinder/app/ui/breadcrumbs"
	"movieFinder/app/ui/confirmationPage"
	"movieFinder/app/ui/errorPage"
	"movieFinder/app/ui/successPage"
	"movieFinder/app/users/login/loginRoutes"
	"movieFinder/app/users/logout/logoutRoutes"
	"movieFinder/app/users/userAccount/userAccountRoutes"
	"movieFinder/app/users/userSession"
	"net/http"
)

func Router(mux *http.ServeMux, ac *appCtx.AppCtx) {
	mux.HandleFunc(logoutRoutes.Logout, Respond(ac))
}

type Data struct {
	UserSession *userSession.UserSession
}

func Respond(ac *appCtx.AppCtx) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodGet:
			respondGet(w, r)
			return
		case http.MethodPost:
			respondPost(ac, w, r)
			return
		default:
			errorPage.New(errors.New("method not allowed")).Redirect(w, r)
		}
	}
}

func respondGet(w http.ResponseWriter, r *http.Request) {
	confirmationPage.ConfirmationPage{
		Headline:    "Logout",
		Body:        "Are you sure you want to logout?",
		ConfirmURL:  logoutRoutes.Logout,
		ConfirmText: "Logout",
		CancelURL:   userAccountRoutes.UserAccountPage,
		CancelText:  "Cancel",
		Breadcrumbs: []breadcrumbs.Breadcrumb{
			{Label: "Home", Href: homeRoutes.FeedPage},
			{Label: "Account", Href: userAccountRoutes.UserAccountPage},
			{Label: "Logout"},
		},
	}.Render(w, r)
}

func respondPost(ac *appCtx.AppCtx, w http.ResponseWriter, r *http.Request) {
	req := reqCtx.FromHttpRequest(ac, r)

	if err := Logout(ac, &req); err != nil {
		errorPage.New(errors.New("failed to logout")).Redirect(w, r)
		return
	}

	successPage.SuccessPage{
		Headline: "Logged out",
		Body:     "You have been successfully logged out",
		NextURL:  loginRoutes.SendLinkPage,
		NextText: "Login",
	}.Redirect(w, r)
}

func Logout(ac *appCtx.AppCtx, rc *reqCtx.ReqCtx) error {
	if rc.UserSession == nil {
		return nil
	}

	uow, err := ac.UowFactory.Begin()
	if err != nil {
		return err
	}
	defer uow.Rollback()

	if err := ac.UserSessionDB.ZapBySessionID(uow, rc.SessionID); err != nil {
		return err
	}

	if err := uow.Commit(); err != nil {
		return err
	}

	return nil
}
