package claimAdmin

import (
	"movieFinder/app/admin/adminRoutes"
	"movieFinder/app/ctx/appCtx"
	"movieFinder/app/ctx/reqCtx"
	"movieFinder/app/home/homeRoutes"
	"movieFinder/app/ui/breadcrumbs"
	"movieFinder/app/ui/confirmationPage"
	"movieFinder/app/ui/errorPage"
	"movieFinder/app/ui/successPage"

	"movieFinder/app/users/userAccount"
	"movieFinder/app/users/userAccount/userRole"
	"net/http"
)

func Router(mux *http.ServeMux, ac *appCtx.AppCtx) {
	mux.HandleFunc(adminRoutes.ClaimAdmin, Respond(ac))
}

func Respond(ac *appCtx.AppCtx) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		rc := reqCtx.FromHttpRequest(ac, r)

		admins, err := ac.UserAccountDB.GetByRole(userRole.Admin)
		if err != nil {
			errorPage.New(err).Redirect(w, r)
			return
		}

		if len(admins) > 0 {
			successPage.New("You are already an admin", homeRoutes.FeedPage, "Home").Redirect(w, r)
			return
		}

		if r.Method == http.MethodPost && rc.UserAccount != nil {
			handlePost(ac, &rc, w, r)
			return
		}

		handleGet(w, r)
	}
}

func handlePost(ac *appCtx.AppCtx, rc *reqCtx.ReqCtx, w http.ResponseWriter, r *http.Request) {
	uow, err := ac.UowFactory.Begin()
	if err != nil {
		errorPage.New(err).Redirect(w, r)
		return
	}
	defer uow.Rollback()

	userAccountNew := userAccount.UserAccount{
		UserID:       rc.UserAccount.UserID,
		EmailAddress: rc.UserAccount.EmailAddress,
		CreatedAt:    rc.UserAccount.CreatedAt,
		UpdatedAt:    rc.UserAccount.UpdatedAt,
		Role:         userRole.Admin,
	}

	if err = ac.UserAccountDB.Upsert(uow, userAccountNew); err != nil {
		errorPage.New(err).Redirect(w, r)
		return
	}

	if err = uow.Commit(); err != nil {
		errorPage.New(err).Redirect(w, r)
		return
	}

	successPage.New("You are now an admin", homeRoutes.FeedPage, "Home").Redirect(w, r)
}

func handleGet(w http.ResponseWriter, r *http.Request) {
	confirmationPage.ConfirmationPage{
		Headline:    "Claim Admin",
		Body:        "Are you sure you want to claim admin?",
		ConfirmURL:  adminRoutes.ClaimAdmin,
		ConfirmText: "Claim",
		CancelURL:   homeRoutes.FeedPage,
		CancelText:  "Cancel",
		Breadcrumbs: []breadcrumbs.Breadcrumb{
			{Label: "Home", Href: homeRoutes.FeedPage},
			{Label: "Claim Admin"},
		},
	}.Redirect(w, r)
}
