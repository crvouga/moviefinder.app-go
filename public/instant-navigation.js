const extractBody = (html) => {
  return /<body[^>]*>([\s\S]*)<\/body>/i.exec(html)[1];
};

const updatePage = async (url) => {
  const res = await fetch(url);
  const html = await res.text();
  document.body.innerHTML = extractBody(html);
  bindLinkHandlers();
};

const bindLinkHandlers = () => {
  document.querySelectorAll("a").forEach((link) => {
    link.addEventListener("mouseenter", async () => {
      // Prefetch on hover but don't cache
      const href = link.getAttribute("href");
      fetch(href);
    });

    link.addEventListener("click", (e) => {
      e.preventDefault();
      const href = link.getAttribute("href");
      updatePage(href);
      history.pushState(null, "", href);
    });
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
window.addEventListener("pageshow", () => {
  updatePage(window.location.pathname);
});
window.addEventListener("pagehide", () => {
  updatePage(window.location.pathname);
});
window.addEventListener("visibilitychange", () => {
  updatePage(window.location.pathname);
});

document.addEventListener("DOMContentLoaded", () => {
  bindLinkHandlers();
});
