//
//  TMDBService.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 07.09.23.
//

import Foundation

protocol TMDB {
    typealias MediaWithPageToQuery = (pageToQueryNext: Int?, mediaSummaries: [Media])
    
    func fetchPopularMovies() async throws -> [Media]
    func fetchGenres() async throws -> [Genre]
}

public class TMDBService: TMDB {
    typealias MediaWithPageToQuery = (pageToQueryNext: Int?, mediaSummaries: [Media])
    
    func fetchPopularMovies() async throws -> [Media] {
        let url = url(with: "/movie/popular")?.url
        
        let mediaWithPageToQuery = try await fetchMediaResult(from: url)
        return mediaWithPageToQuery.mediaSummaries
    }
    
    func fetchGenres() async throws -> [Genre] {
        guard let url = url(with: "/genre/movie/list")?.url else {
            throw NetworkRequestError.urlError
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        _ = try responseIsSuccessful(response)
        
        let genres = try JSONDecoder().decode(GenreResult.self, from: data).genres
        return genres
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
