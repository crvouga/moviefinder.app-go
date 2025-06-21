const cache = {};

const extractBody = (html) => {
  return /<body[^>]*>([\s\S]*)<\/body>/i.exec(html)[1];
};

const updatePage = async (url) => {
  const res = await fetch(url);
  const html = await res.text();
  document.body.innerHTML = extractBody(html);
  bindLinkHandlers();
};

const preload = async (link) => {
  const href = link.getAttribute("href");
  if (!href) return;
  const res = await fetch(href);
  const html = await res.text();
  cache[href] = html;
};

const bindLinkHandlers = () => {
  document.querySelectorAll("a").forEach((link) => {
    link.addEventListener("mouseenter", () => preload(link));
    link.addEventListener("touchstart", () => preload(link));
    link.addEventListener("click", (e) => {
      e.preventDefault();
      const href = link.getAttribute("href");
      if (!href) return;
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
document.addEventListener("DOMContentLoaded", () => {
  bindLinkHandlers();
});
