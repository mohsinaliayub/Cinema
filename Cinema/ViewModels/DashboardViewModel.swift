//
//  DashboardViewModel.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 07.09.23.
//

import Foundation

class DashboardViewModel: ObservableObject {
    @Published var popularMovies: [Media]
    private var tmdb: TMDB
    
    init(tmdb: TMDB) {
        popularMovies = []
        self.tmdb = tmdb
    }
    
    func fetchPopularMovies() async throws {
        let movies = try await tmdb.fetchPopularMovies()
        await MainActor.run {
            popularMovies = movies
        }
    }
}
