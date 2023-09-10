//
//  Media.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 07.09.23.
//

import Foundation

public typealias MediaID = Int

public struct Media: Identifiable {
    public let id: MediaID
    public let mediaType: MediaType
    private var movieTitle: String? = nil
    private var tvName: String? = nil
    public let overview: String
    public let backdropURL: URL?
    public let posterURL: URL?
    public let genreIds: [Int]
    private let releaseDate: Date?
    public let imdbRating: Double
    
    public var title: String {
        movieTitle ?? tvName ?? ""
    }
    
    public init(id: MediaID, mediaType: MediaType, title: String, overview: String, backdropURLString: String,
                posterURLString: String, genreIds: [Int], releaseDateString: String, imdbRating: Double) {
        self.id = id
        self.mediaType = mediaType
        if mediaType == .movie {
            self.movieTitle = title
        } else {
            self.tvName = title
        }
        self.overview = overview
        self.backdropURL = URL(string: Constants.APIConstants.baseURLForImages + backdropURLString)
        self.posterURL = URL(string: Constants.APIConstants.baseURLForImages + posterURLString)
        self.genreIds = genreIds
        self.releaseDate = shortDateFormatter.date(from: releaseDateString)
        self.imdbRating = imdbRating
    }
    
    private var shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        return formatter
    }()
    
    public func releaseDate(withFormat format: String) -> String? {
        releaseDate?.format(format)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, overview
        case movieTitle = "title"
        case tvName = "name"
        case releaseDate = "release_date"
        case backdropURL = "backdrop_path"
        case posterURL = "poster_path"
        case mediaType = "media_type"
        case genreIds = "genre_ids"
        case imdbRating = "vote_average"
    }
}

extension Media: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        movieTitle = try container.decodeIfPresent(String.self, forKey: .movieTitle)
        tvName = try container.decodeIfPresent(String.self, forKey: .tvName)
        overview = try container.decode(String.self, forKey: .overview)
        mediaType = try container.decodeIfPresent(MediaType.self, forKey: .mediaType) ?? .movie
        genreIds = try container.decodeIfPresent([Int].self, forKey: .genreIds) ?? []
        if let backdropImage = try container.decodeIfPresent(String.self, forKey: .backdropURL) {
            backdropURL = URL(string: Constants.APIConstants.baseURLForImages + backdropImage)
        } else {
            backdropURL = nil
        }
        if let posterImage = try container.decodeIfPresent(String.self, forKey: .posterURL) {
            posterURL = URL(string: Constants.APIConstants.baseURLForImages + posterImage)
        } else {
            posterURL = nil
        }
        
        if let releaseDateString = try container.decodeIfPresent(String.self, forKey: .releaseDate) {
            releaseDate = shortDateFormatter.date(from: releaseDateString)
        } else {
            releaseDate = nil
        }
        imdbRating = try container.decode(Double.self, forKey: .imdbRating)
    }
}

extension Media: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Media, rhs: Media) -> Bool {
        lhs.id == rhs.id
    }
}

