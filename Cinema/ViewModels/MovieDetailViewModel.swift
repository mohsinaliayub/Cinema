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
    
    private(set) var tmdb: TMDB
    
    init(movie: Media, tmdb: TMDB) {
        self.movie = movie
        self.cast = []; self.reviews = []
        self.tmdb = tmdb
    }
    
    func fetchData() async throws {
        async let castTask = try fetchCast()
        async let reviewsTask = try fetchReviews()
        
        let (cast, reviews) = try await (castTask, reviewsTask)
        
        await MainActor.run {
            self.cast = Array(cast.prefix(10))
            self.reviews = Array(reviews.prefix(3))
        }
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
