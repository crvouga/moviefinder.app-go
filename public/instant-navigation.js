const cache = {};

const extractBody = (html) => {
  return /<body[^>]*>([\s\S]*)<\/body>/i.exec(html)[1];
};

const bindLinkHandlers = () => {
  document.querySelectorAll("a").forEach((link) => {
    link.addEventListener("mouseenter", async () => {
      const href = link.getAttribute("href");
      const res = await fetch(href);
      const text = await res.text();
      cache[href] = text;
    });

    link.addEventListener("click", (e) => {
      e.preventDefault();
      const href = link.getAttribute("href");
      document.body.innerHTML = extractBody(cache[href]);
      history.pushState(null, "", href);
      bindLinkHandlers(); // Rebind handlers after DOM update
    });
  });
};

document.addEventListener("DOMContentLoaded", () => {
  bindLinkHandlers();
});
