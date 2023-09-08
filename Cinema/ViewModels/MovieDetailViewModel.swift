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
    
    private(set) var tmdb: TMDB
    
    init(movie: Media, tmdb: TMDB) {
        self.movie = movie
        self.cast = []
        self.tmdb = tmdb
    }
    
    func fetchData() async throws {
        async let castTask = try fetchCast()
        
        let cast = try await castTask
        
        await MainActor.run {
            self.cast = cast
        }
    }
    
    private func fetchCast() async throws -> [Cast] {
        let cast = try await tmdb.fetchCast(for: movie.id)
        return Array(cast.prefix(10))
    }
}
