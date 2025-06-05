package media

type Media struct {
	ID           int
	Title        string
	Description  string
	PosterURLs   []string
	BackdropURLs []string
	Popularity   float64
	ReleaseDate  string
	VoteAverage  float64
	VoteCount    int
	Genres       []string
	Runtime      int
	Status       string
	Tagline      string
}
