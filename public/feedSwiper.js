const PRELOAD_THRESHOLD = 3;
document.addEventListener("DOMContentLoaded", () => {
  const swiper = document.getElementById("feed-swiper");
  const swiperSlideLast = document.getElementById("feed-swiper-slide-last");
  swiper.addEventListener("swiperslidechange", async (event) => {
    const shouldLoadNext =
      swiper.swiper.activeIndex >=
      swiper.swiper.slides.length - PRELOAD_THRESHOLD;
    if (shouldLoadNext) {
      const lastFeedIndex =
        parseInt(
          event?.detail?.[0]?.slides?.[
            event?.detail?.[0]?.slides?.length - 2
          ]?.getAttribute?.("data-feed-index"),
          10
        ) || 0;
      const startingFeedIndex = lastFeedIndex + 1;
      const html = await fetch(
        `${LOAD_NEXT_URL}?startingFeedIndex=${startingFeedIndex}`
      ).then((r) => r.text());
      swiperSlideLast.insertAdjacentHTML("beforebegin", html);
    }

    const feedIndex = parseInt(
      event?.detail?.[0]?.slides?.[
        event?.detail?.[0]?.activeIndex
      ]?.getAttribute?.("data-feed-index"),
      10
    );

    await fetch(`${SLIDE_CHANGED_URL}?feedIndex=${feedIndex}`, {
      method: "POST",
    });
  });
});
