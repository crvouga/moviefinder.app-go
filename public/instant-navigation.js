navigator.serviceWorker?.register("/instant-navigation-sw.js");

const requestCacheUpdate = (url) => {
  navigator.serviceWorker.controller?.postMessage({
    type: "UPDATE_CACHE",
    url: url,
  });
};

const preload = (link) => {
  const href = link.getAttribute("href");
  if (!href) return;
  requestCacheUpdate(href);
};

const bindLinkHandlers = () => {
  document.querySelectorAll("a").forEach((link) => {
    link.addEventListener("mouseenter", () => preload(link));
    link.addEventListener("touchstart", () => preload(link));
  });
};

document.addEventListener("DOMContentLoaded", () => {
  bindLinkHandlers();
});

let previousHref =
  sessionStorage.getItem("previousHref") || window.location.href;
const onNavigation = () => {
  const currentHref = window.location.href;
  requestCacheUpdate(previousHref);
  requestCacheUpdate(currentHref);
  sessionStorage.setItem("previousHref", currentHref);
  previousHref = currentHref;
};
window.addEventListener("popstate", onNavigation);
window.addEventListener("pushstate", onNavigation);
window.addEventListener("replacestate", onNavigation);
window.addEventListener("hashchange", onNavigation);
