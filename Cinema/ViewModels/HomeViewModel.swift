//
//  HomeViewModel.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 11.09.23.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var movies: [Media]
    @Published var selectedResult: MovieResultType = .nowPlaying
    
    let tmdb: TMDB
    
    init(tmdb: TMDB) {
        self.tmdb = tmdb
        movies = []
    }
    
    func fetchData() async throws {
        let movies = try await tmdb.fetchMovies(by: selectedResult)
        
        await MainActor.run {
            self.movies = movies
        }
    }
    
    
    
}
