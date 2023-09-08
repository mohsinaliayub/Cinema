//
//  Review.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 08.09.23.
//

import Foundation

struct Review: Identifiable {
    let id: String
    let authorDetails: ReviewAuthor
    let author: String
    let content: String
    let createdAt: Date?
    let url: URL?
    
    init(id: String, authorDetails: ReviewAuthor, author: String, content: String, createdAt: Date, url: URL?) {
        self.id = id
        self.authorDetails = authorDetails
        self.author = author
        self.content = content
        self.createdAt = createdAt
        self.url = url
    }
    
    enum CodingKeys: String, CodingKey {
        case id, author, content, url
        case authorDetails = "author_details"
        case createdAt = "created_at"
    }
}

extension Review: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        author = try container.decode(String.self, forKey: .author)
        authorDetails = try container.decode(ReviewAuthor.self, forKey: .authorDetails)
        content = try container.decode(String.self, forKey: .content)
        url = try container.decodeIfPresent(URL.self, forKey: .url)
        if let createdAtDateString = try container.decodeIfPresent(String.self, forKey: .createdAt) {
            let dateFormatter = ISO8601DateFormatter()
            dateFormatter.formatOptions = [.withFractionalSeconds, .withInternetDateTime]
            createdAt = dateFormatter.date(from: createdAtDateString)
        } else { createdAt = nil }
    }
}
