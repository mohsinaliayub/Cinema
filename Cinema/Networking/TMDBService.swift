//
//  TMDBService.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 07.09.23.
//

import Foundation

protocol TMDB {
    typealias MediaWithPageToQuery = (pageToQueryNext: Int?, mediaSummaries: [Media])
    
    var genres: [Genre] { get set }
    
    func fetchPopularMovies() async throws -> [Media]
    func fetchGenres() async throws -> [Genre]
    func fetchCast(for movieId: MediaID) async throws -> [Cast]
    func fetchReviews(for movieId: MediaID) async throws -> [Review]
    func fetchMoviesByQuery(_ query: String) async throws -> [Media]
}

public class TMDBService: TMDB {
    typealias MediaWithPageToQuery = (pageToQueryNext: Int?, mediaSummaries: [Media])
    
    var genres: [Genre] = []
    
    func fetchPopularMovies() async throws -> [Media] {
        let url = url(with: "/movie/popular")?.url
        
        let mediaWithPageToQuery = try await fetchMediaResult(from: url)
        return mediaWithPageToQuery.mediaSummaries
    }
    
    func fetchGenres() async throws -> [Genre] {
        guard genres.isEmpty else { return genres }
        guard let url = url(with: "/genre/movie/list")?.url else {
            throw NetworkRequestError.urlError
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        _ = try responseIsSuccessful(response)
        
        let genres = try JSONDecoder().decode(GenreResult.self, from: data).genres
        self.genres = genres
        return genres
    }
    
    func fetchCast(for movieId: MediaID) async throws -> [Cast] {
        guard let url = url(with: "/movie/\(movieId)/credits")?.url else {
            throw NetworkRequestError.urlError
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        _ = try responseIsSuccessful(response)
        
        let credits = try JSONDecoder().decode(Credits.self, from: data)
        return credits.cast
    }
    
    func fetchReviews(for movieId: MediaID) async throws -> [Review] {
        guard let url = url(with: "/movie/\(movieId)/reviews")?.url else {
            throw NetworkRequestError.urlError
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        _ = try responseIsSuccessful(response)
        
        let reviews = try JSONDecoder().decode(ReviewResult.self, from: data).reviews
        return reviews
    }
    
    func fetchMoviesByQuery(_ query: String) async throws -> [Media] {
        var components = url(with: "/search/movie")
        components?.addQueryItem(withName: "query", andValue: query)
        
        let mediaWithPageToQuery = try await fetchMediaResult(from: components?.url)
        return mediaWithPageToQuery.mediaSummaries
    }
    
    private func fetchMediaResult(from url: URL?) async throws -> MediaWithPageToQuery {
        // Get url or throw url error.
        guard let url = url else { throw NetworkRequestError.urlError }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        _ = try responseIsSuccessful(response)
        
        let mediaResult = try JSONDecoder().decode(MediaResult.self, from: data)
        return (mediaResult.page + 1, mediaResult.results)
    }
    
    private func url(with string: String) -> URLComponents? {
        var components = URLComponents(string: Constants.APIConstants.baseURL + string)
        components?.setQueryItems(with: ["api_key": Constants.APIConstants.apiKey])
        
        return components
    }
    
    private func url(_ url: URL?) throws -> URL {
        guard let url = url else { throw NetworkRequestError.urlError }
        return url
    }
    
    private func responseIsSuccessful(_ urlResponse: URLResponse) throws -> Bool {
        if let networkError = NetworkRequestError.networkError(from: urlResponse as? HTTPURLResponse) {
            throw networkError
        }
        
        return true
    }
}
