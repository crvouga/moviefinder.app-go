package swiper

type Swiper struct {
	Items []SwiperItem
}

type SwiperItem struct {
	Label       string
	URL         string
	Description string
}
