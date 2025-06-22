navigator.serviceWorker?.register("/sw.js");
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
    link.addEventListener("pointerenter", () => preload(link));
  });
};
document.addEventListener("DOMContentLoaded", onLoad);
const requestCacheUpdateCurrentPage = () => {
  requestCacheUpdate(window.location.href);
};
window.requestCacheUpdateCurrentPage = requestCacheUpdateCurrentPage;
window.addEventListener("popstate", requestCacheUpdateCurrentPage);
window.addEventListener("pushstate", requestCacheUpdateCurrentPage);
window.addEventListener("replacestate", requestCacheUpdateCurrentPage);
window.addEventListener("hashchange", requestCacheUpdateCurrentPage);
