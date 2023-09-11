//
//  DummyTMDBService.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 07.09.23.
//

import Foundation

class DummyTMDBService: TMDB {
    
    func fetchPopularMovies() async throws -> [Media] {
        media
    }
    
    func fetchGenres() async throws -> [Genre] {
        genres
    }
    
    func fetchCast(for movieId: MediaID) async throws -> [Cast] {
        cast
    }
    
    func fetchReviews(for movieId: MediaID) async throws -> [Review] {
        reviews
    }
    
    func fetchMoviesByQuery(_ query: String) async throws -> [Media] {
        media
    }
    
    var reviews: [Review] = [
        Review(id: "64cca1aa798e0600e363c076", authorDetails: ReviewAuthor(name: "Louisa Moore - Screen Zealots", username: "screenzealots", rating: 3.0, avatarURLString: "/1kks3YnVkpyQxzw36CObFPvhL5f.jpg"), author: "Louisa Moore - Screen Zealots", content: "There’s a sweet life lesson at the heart of “No Hard Feelings,” the supposed “raunchy comedy” from co-writer and director Gene Stupnitsky. What a shame that it’s buried under a heap of dreadfully unfunny attempts at humor, dumb pratfalls,and tired sex jokes that fall flat one hundred percent of the time. No bones about it: this is not just a really terrible comedy, it’s an awful movie all around.\r\n\r\nBartender Maddie (Jennifer Lawrence) just watched her car get towed from the driveway, and needs wheels, fast. While browsing the want ads, she stumbles upon an intriguing job listing: wealthy helicopter parents (Laura Benanti, Matthew Broderick) are searching for someone to “date” their introverted 19-year-old son, Percy (Andrew Barth Feldman), before he leaves for college. The pay for sleeping with their son? A used Buick. Maddie decides to take the job but in the process, she gets far more than she bargains for.\r\n\r\nIt’s a decent premise for a movie, but Lawrence is horribly miscast in the role. She’s too old to play the part of Maddie, which makes her relationship with a teenager feel a little icky. Lawrence is also called on to do a lot of comedy work and as talented as she is, she simply lacks the knack for comedic timing (she’s especially awful at physical comedy).\r\n\r\nIt’s also a problematic message to send to young men: if you haven’t slept with a woman before venturing away from home and off into adulthood, then you aren’t much of a “man.” Just think if the roles were reversed here, and it was a 32 year old man trying to force himself on a 19 year old woman so she could get “experience” before heading to college. The standard needs to be the same regardless of the sex of the main characters.\r\n\r\nThe majority of the story consists of ridiculous situations where Maddie is aggressively trying to seduce Percy, none of them funny and all of them growing old, quickly. Stupnitsky (and co-writer John Phillips) go for the lowest hanging fruit every time, and the only laughter I could muster while watching this dreck came from forced chuckles.\r\n\r\nAnd that’s the major problem with the movie: everyone is trying so hard to turn it into a wacky, racy comedy that they miss the actual heart of the story.\r\n\r\nThe relationship between Maddie and Percy is somewhat charming, and the way they grow individually while together is actually heartwarming. All of that is overshadowed by the lame attempts to make it a raunchy, sexy, adult comedy. In struggling to be both, it succeeds at neither.\r\n\r\n“No Hard Feelings” is best when it stops trying to be something it’s not.", createdAt: Date(), url: URL(string: "https://www.themoviedb.org/review/64cca1aa798e0600e363c076"))
    ]
    
    var cast: [Cast] = [
        Cast(id: 72129, name: "Jennifer Lawrence", character: "Maddie Barker", order: 0, profileURLString: "/mDKMsjOMytyBiy7MHNZTa7gp7wj.jpg"),
        Cast(id: 2914688, name: "Andrew Barth Feldman", character: "Percy Becker", order: 1, profileURLString: "/17rLE4Q4gKejJp1TsByGnzMpK00.jpg"),
        Cast(id: 60034, name: "Laura Benanti", character: "Allison Becker", order: 2, profileURLString: "/meoraoVzlCExK6RUFX2GqVNv0vw.jpg"),
        Cast(id: 4756, name: "Matthew Broderick", character: "Laird Becker", order: 3, profileURLString: "/2Pq8pwOX5ZFfT2p5pNLGfvUi9Pp.jpg"),
        Cast(id: 118752, name: "Natalie Morales", character: "Sara", order: 4, profileURLString: "/faHjkHWepBM2mx8lq7kS0D3YeOE.jpg"),
    ]
    
    var genres: [Genre] = [
        Genre(id: 28, name: "Action"),
        Genre(id: 12, name: "Adventure"),
        Genre(id: 16, name: "Animation"),
        Genre(id: 35, name: "Comedy"),
        Genre(id: 80, name: "Crime")
    ]
    
    var media: [Media] = [
        Media(id: 884605,
              mediaType: .movie,
              title: "No Hard Feelings",
              overview: "On the brink of losing her childhood home, Maddie discovers an intriguing job listing: wealthy helicopter parents looking for someone to “date” their introverted 19-year-old son, Percy, before he leaves for college. To her surprise, Maddie soon discovers the awkward Percy is no sure thing.",
              backdropURLString: "/rRcNmiH55Tz0ugUsDUGmj8Bsa4V.jpg",
              posterURLString: "/4K7gQjD19CDEPd7A9KZwr2D9Nco.jpg",
              genreIds: [35, 10749],
              releaseDateString: "2023-06-15",
              imdbRating: 7.0),
        Media(id: 724209,
              mediaType: .movie,
              title: "Heart of Stone",
              overview: "An intelligence operative for a shadowy global peacekeeping agency races to stop a hacker from stealing its most valuable — and dangerous — weapon.",
              backdropURLString: "/xVMtv55caCEvBaV83DofmuZybmI.jpg",
              posterURLString: "/vB8o2p4ETnrfiWEgVxHmHWP9yRl.jpg",
              genreIds: [53, 28],
              releaseDateString: "2023-08-09",
              imdbRating: 7.0),
        Media(id: 569094,
              mediaType: .movie,
              title: "Spider-Man: Across the Spider-Verse",
              overview: "After reuniting with Gwen Stacy, Brooklyn’s full-time, friendly neighborhood Spider-Man is catapulted across the Multiverse, where he encounters the Spider Society, a team of Spider-People charged with protecting the Multiverse’s very existence. But when the heroes clash on how to handle a new threat, Miles finds himself pitted against the other Spiders and must set out on his own to save those he loves most.",
              backdropURLString: "/4HodYYKEIsGOdinkGi2Ucz6X9i0.jpg",
              posterURLString: "/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg",
              genreIds: [16, 28, 12, 878],
              releaseDateString: "2023-05-31",
              imdbRating: 8.5),
        Media(id: 346698,
              mediaType: .movie,
              title: "Barbie",
              overview: "Barbie and Ken are having the time of their lives in the colorful and seemingly perfect world of Barbie Land. However, when they get a chance to go to the real world, they soon discover the joys and perils of living among humans.",
              backdropURLString: "/nHf61UzkfFno5X1ofIhugCPus2R.jpg",
              posterURLString: "/iuFNMS8U5cb6xfzi51Dbkovj7vM.jpg",
              genreIds: [35, 12, 14],
              releaseDateString: "2023-07-19",
              imdbRating: 7.4),
    ]
}
