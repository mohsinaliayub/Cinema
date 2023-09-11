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
    @Published var fetchingData = false
    private(set) var tmdb: TMDB
    
    init(tmdb: TMDB) {
        self.tmdb = tmdb
        genres = tmdb.genres
        movies = []
    }
    
    func fetchData() async throws {
        guard tmdb.genres.isEmpty else { return }
        
        _ = try await tmdb.fetchGenres()
    }
    
    func fetchMoviesBySearch() async throws {
        let movies = try await tmdb.fetchMoviesByQuery(searchText)
        await MainActor.run {
            self.movies = movies
        }
    }
    
    func fetchMoviesByType(_ type: MediaResultType) async throws {
//        movies = []
    }
    
    func fetchGenres(for media: Media) -> [Genre] {
        guard !genres.isEmpty else { return [] }
        
        var genres = [Genre]()
        media.genreIds.forEach { genreId in
            if let genre = fetchGenre(byId: genreId) {
                genres.append(genre)
            }
        }
        return genres
    }
    
    private func fetchGenre(byId id: Int) -> Genre? {
        genres.first { $0.id == id }
    }
}
