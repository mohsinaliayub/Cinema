//
//  ReviewAuthor.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 08.09.23.
//

import Foundation

struct ReviewAuthor {
    let name: String
    let username: String
    let rating: Double?
    let avatarURL: URL?
    
    init(name: String, username: String, rating: Double, avatarURLString: String?) {
        self.name = name
        self.username = username
        self.rating = rating
        if let avatarURLString {
            self.avatarURL = URL(string: Constants.APIConstants.baseURLForImages + avatarURLString)
        } else { avatarURL = nil }
    }
    
    enum CodingKeys: String, CodingKey {
        case name, username, rating
        case avatarURL = "avatar_path"
    }
}

extension ReviewAuthor: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        username = try container.decode(String.self, forKey: .username)
        rating = try container.decodeIfPresent(Double.self, forKey: .rating)
        if let urlString = try container.decodeIfPresent(String.self, forKey: .avatarURL) {
            avatarURL = URL(string: Constants.APIConstants.baseURLForImages + urlString)
        } else { avatarURL = nil }
    }
}
