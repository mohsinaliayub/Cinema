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
