//
//  ExploreMoviesViewModel.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 10.09.23.
//

import Foundation

class ExploreMoviesViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var genres: [Genre]
    @Published var movies: [Media]
    private(set) var tmdb: TMDB
    
    init(tmdb: TMDB) {
        self.tmdb = tmdb
        genres = tmdb.genres
        movies = []
    }
    
    func fetchMoviesBySearch() async throws {
        movies = try await tmdb.fetchPopularMovies()
    }
    
}
