if ("serviceWorker" in navigator) {
  navigator.serviceWorker
    .register("/instant-navigation-sw.js")
    .then((registration) => {
      console.log("Service worker registered", registration);
    })
    .catch((error) => {
      console.error("Service worker registration failed", error);
    });
}

// Send message to service worker to update cache
const requestCacheUpdate = (url) => {
  if (navigator.serviceWorker.controller) {
    navigator.serviceWorker.controller.postMessage({
      type: "UPDATE_CACHE",
      url: url,
    });
  }
};

const updatePage = async (url) => {
  // Tell service worker to update cache in background
  requestCacheUpdate(url);
};

const preload = (link) => {
  const href = link.getAttribute("href");
  if (!href) return;

  // Tell service worker to fetch and cache this URL
  requestCacheUpdate(href);
  console.log("Requested cache update for:", href);
};

const bindLinkHandlers = () => {
  document.querySelectorAll("a").forEach((link) => {
    link.addEventListener("mouseenter", () => preload(link));
    link.addEventListener("touchstart", () => preload(link));
  });
};

window.addEventListener("popstate", () => {
  updatePage(window.location.pathname);
});
window.addEventListener("pushstate", () => {
  updatePage(window.location.pathname);
});
window.addEventListener("replacestate", () => {
  updatePage(window.location.pathname);
});
window.addEventListener("hashchange", () => {
  updatePage(window.location.pathname);
});
document.addEventListener("DOMContentLoaded", () => {
  bindLinkHandlers();
});
