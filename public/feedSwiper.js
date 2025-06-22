const PRELOAD_THRESHOLD = 3;
document.addEventListener("DOMContentLoaded", () => {
  const swiper = document.getElementById("feed-swiper");
  const swiperSlideLast = document.getElementById("feed-swiper-slide-last");

  swiper.addEventListener("swiperslidechange", async (event) => {
    const swiperInstance = swiper.swiper;
    const eventDetails = event?.detail?.[0];
    const slides = eventDetails?.slides || [];

    const isNearEnd =
      swiperInstance.activeIndex >=
      swiperInstance.slides.length - PRELOAD_THRESHOLD;

    if (isNearEnd) {
      const secondToLastSlide = slides[slides.length - 2];
      const lastFeedIndex =
        parseInt(secondToLastSlide?.getAttribute("data-feed-index"), 10) || 0;

      const startingFeedIndex = lastFeedIndex + 1;
      const response = await fetch(
        `${LOAD_NEXT_URL}?startingFeedIndex=${startingFeedIndex}`
      );
      const newSlidesHtml = await response.text();
      swiperSlideLast.insertAdjacentHTML("beforebegin", newSlidesHtml);
    }

    const currentSlide = slides[swiperInstance.activeIndex];
    const currentFeedIndex = parseInt(
      currentSlide?.getAttribute("data-feed-index"),
      10
    );
    window.requestCacheUpdateCurrentPage();
    await fetch(`${SLIDE_CHANGED_URL}?feedIndex=${currentFeedIndex}`, {
      method: "POST",
    });
  });
});
