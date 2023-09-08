//
//  DashboardViewModel.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 07.09.23.
//

import Foundation

class DashboardViewModel: ObservableObject {
    @Published var popularMovies: [Media]
    private var genres: [Genre]
    private let tmdb: TMDB
    
    init(tmdb: TMDB) {
        popularMovies = []; genres = []
        self.tmdb = tmdb
    }
    
    func fetchData() async throws {
        async let genresTask = try fetchGenres()
        async let moviesTask = try fetchPopularMovies()
        
        let (genres, movies) = try await (genresTask, moviesTask)
        await MainActor.run {
            self.genres = genres
            self.popularMovies = movies
        }
    }
    
    func fetchPopularMovies() async throws -> [Media] {
        let movies = try await tmdb.fetchPopularMovies()
        return movies
    }
    
    func fetchGenres() async throws -> [Genre] {
        let genres = try await tmdb.fetchGenres()
        return genres
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
