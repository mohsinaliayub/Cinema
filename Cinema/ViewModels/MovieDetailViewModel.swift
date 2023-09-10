//
//  MovieDetailViewModel.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 08.09.23.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    @Published var movie: Media
    @Published var cast: [Cast]
    @Published var reviews: [Review]
    @Published var genres: [Genre]
    
    private(set) var tmdb: TMDB
    
    init(movie: Media, tmdb: TMDB) {
        self.movie = movie
        self.cast = []; self.reviews = []
        self.genres = []
        self.tmdb = tmdb
    }
    
    func fetchData() async throws {
        async let castTask = try fetchCast()
        async let reviewsTask = try fetchReviews()
        
        let (cast, reviews) = try await (castTask, reviewsTask)
        
        await MainActor.run {
            self.cast = Array(cast.prefix(10))
            self.reviews = Array(reviews.prefix(3))
            self.genres = fetchGenres()
        }
    }
    
    private func fetchGenres() -> [Genre] {
        guard !tmdb.genres.isEmpty else { return [] }
        
        var genres = [Genre]()
        movie.genreIds.forEach { genreId in
            if let genre = fetchGenre(byId: genreId) {
                genres.append(genre)
            }
        }
        return genres
    }
    
    private func fetchGenre(byId id: Int) -> Genre? {
        tmdb.genres.first { $0.id == id }
    }
    
    private func fetchCast() async throws -> [Cast] {
        try await tmdb.fetchCast(for: movie.id)
    }
    
    private func fetchReviews() async throws -> [Review] {
        do {
            return try await tmdb.fetchReviews(for: movie.id)
        } catch {
            print(error)
        }
        return []
    }
}
