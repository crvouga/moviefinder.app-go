const CACHE_NAME = "html-cache-v1";

self.addEventListener("install", (event) => {
  self.skipWaiting();
});

self.addEventListener("activate", (event) => {
  clients.claim();
});

// Listen for messages from main thread
self.addEventListener("message", (event) => {
  if (event.data && event.data.type === "UPDATE_CACHE") {
    updateCache(event.data.url);
  }
});

// Update cache with fresh content
const updateCache = async (url) => {
  try {
    const cache = await caches.open(CACHE_NAME);
    const response = await fetch(url, { cache: "reload" });

    if (response.ok) {
      await cache.put(url, response.clone());
      console.log("Service worker updated cache for:", url);
    }
  } catch (error) {
    console.error("Service worker failed to update cache for:", url, error);
  }
};

self.addEventListener("fetch", (event) => {
  const req = event.request;

  // Only handle GET navigation requests
  if (req.method !== "GET" || req.mode !== "navigate") return;

  event.respondWith(
    caches.open(CACHE_NAME).then(async (cache) => {
      const cachedResponse = await cache.match(req);

      // If we have cached content, return it immediately
      if (cachedResponse) {
        return cachedResponse;
      }

      // Otherwise fetch from network
      const networkResponse = await fetch(req);
      if (networkResponse.ok) {
        cache.put(req, networkResponse.clone());
      }
      return networkResponse;
    })
  );
});
