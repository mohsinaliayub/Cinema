//
//  Movie.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 07.09.23.
//

import Foundation

public struct Movie: Identifiable {
    public let id: MediaID
    public let title: String
    public let overview: String
    public let posterPath: URL?
    public let backdropPath: URL?
    public let genres: [Genre]
    public let releaseDate: Date?
    public let imdbRating: Double
    public let runtime: Int // runtime in minutes
    public var runtimeInHoursAndMinutes: String {
        let hours = runtime / 60
        let minutes = runtime % 60
        return "\(hours)h \(minutes)m"
    }
    
    public init(id: MediaID, title: String, overview: String, posterPath: String,
         backdropPath: String, genres: [Genre], releaseDateString: String,
         imdbRating: Double, runtime: Int) {
        self.id = id
        self.title = title
        self.overview = overview
        self.posterPath = URL(string: Constants.APIConstants.baseURLForImages + posterPath)
        self.backdropPath = URL(string: Constants.APIConstants.baseURLForImages + backdropPath)
        self.genres = genres
        let dateFormatter = DateFormatter(); dateFormatter.dateFormat = "YYYY-MM-DD"
        self.releaseDate = dateFormatter.date(from: releaseDateString)
        self.imdbRating = imdbRating
        self.runtime = runtime
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, genres, runtime
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case imdbRating = "vote_average"
    }
}

extension Movie: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(MediaID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        if let posterUrlString = try container.decodeIfPresent(String.self, forKey: .posterPath) {
            posterPath = URL(string: Constants.APIConstants.baseURLForImages + posterUrlString)
        } else { posterPath = nil }
        if let backdropUrlString = try container.decodeIfPresent(String.self, forKey: .backdropPath) {
            backdropPath = URL(string: Constants.APIConstants.baseURLForImages + backdropUrlString)
        } else { backdropPath = nil }
        genres = try container.decode([Genre].self, forKey: .genres)
        imdbRating = try container.decode(Double.self, forKey: .imdbRating)
        runtime = try container.decode(Int.self, forKey: .runtime)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        let releaseDateString = try container.decode(String.self, forKey: .releaseDate)
        releaseDate = dateFormatter.date(from: releaseDateString)
    }
}
