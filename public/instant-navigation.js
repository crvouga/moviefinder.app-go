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
const onLoad = () => {
  document.querySelectorAll("a").forEach((link) => {
    preload(link);
    link.addEventListener("pointerover", () => preload(link));
    link.addEventListener("pointerdown", () => preload(link));
  });
};
document.addEventListener("DOMContentLoaded", onLoad);
const onNavigation = () => {
  requestCacheUpdate(window.location.href);
};
window.addEventListener("popstate", onNavigation);
window.addEventListener("pushstate", onNavigation);
window.addEventListener("replacestate", onNavigation);
window.addEventListener("hashchange", onNavigation);
