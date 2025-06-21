const CACHE_NAME = "html-cache-v1";

self.addEventListener("install", (event) => {
  self.skipWaiting();
});

self.addEventListener("activate", (event) => {
  clients.claim();
});

self.addEventListener("fetch", (event) => {
  const req = event.request;

  // Only handle GET navigation requests
  if (req.method !== "GET" || req.mode !== "navigate") return;

  event.respondWith(
    caches.open(CACHE_NAME).then(async (cache) => {
      const cachedResponse = await cache.match(req);

      // Fetch latest in background and update cache
      const fetchPromise = fetch(req).then((networkResponse) => {
        if (networkResponse.ok) {
          cache.put(req, networkResponse.clone());
        }
        return networkResponse;
      });

      // Return cached response if available, otherwise wait for network
      return cachedResponse || fetchPromise;
    })
  );
});
