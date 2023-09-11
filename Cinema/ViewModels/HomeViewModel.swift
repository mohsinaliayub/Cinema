//
//  HomeViewModel.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 11.09.23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var genres: [Genre] = []
    @Published var movies: [Media]
    @Published var selectedResult: MovieResultType = .nowPlaying
    @Published var fetching = false
    
    let tmdb: TMDB
    
    init(tmdb: TMDB) {
        self.tmdb = tmdb
        movies = []
    }
    
    func fetchData() async throws {
        await updateFetching(true)
        
        async let moviesAsync = try tmdb.fetchMovies(by: selectedResult)
        async let genresAsync = try tmdb.fetchGenres()
        
        let (movies, genres) = try await (moviesAsync, genresAsync)
        
        await MainActor.run {
            self.movies = movies
            self.genres = genres
            self.fetching = false
        }
    }
    
    @MainActor
    private func updateFetching(_ fetching: Bool) {
        self.fetching = fetching
    }
}
