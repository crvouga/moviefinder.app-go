const CACHE_NAME = "html-cache-v1";

self.addEventListener("install", (event) => {
  self.skipWaiting();
});

self.addEventListener("activate", (event) => {
  clients.claim();
});

self.addEventListener("message", (event) => {
  if (event.data && event.data.type === "UPDATE_CACHE") {
    updateCache(event.data.url);
  }
});

const updateCache = async (url) => {
  const cache = await caches.open(CACHE_NAME);
  const response = await fetch(url, { cache: "reload" });
  if (response.ok) {
    await cache.put(url, response.clone());
  }
};

self.addEventListener("fetch", (event) => {
  const req = event.request;

  if (req.method !== "GET" || req.mode !== "navigate") return;

  event.respondWith(
    caches.open(CACHE_NAME).then(async (cache) => {
      const cachedResponse = await cache.match(req);

      if (cachedResponse) {
        return cachedResponse;
      }

      const networkResponse = await fetch(req);

      if (networkResponse.ok) {
        cache.put(req, networkResponse.clone());
      }

      return networkResponse;
    })
  );
});
