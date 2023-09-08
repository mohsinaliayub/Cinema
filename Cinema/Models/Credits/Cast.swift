//
//  Cast.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 08.09.23.
//

import Foundation

struct Cast: Identifiable {
    let id: Int
    let name: String
    let character: String
    let order: Int
    private let profileURLString: String?
    var profilePictureURL: URL? {
        guard let profileURLString else { return nil }
        return URL(string: Constants.APIConstants.baseURLForImages + profileURLString)
    }
    
    init(id: Int, name: String, character: String, order: Int, profileURLString: String) {
        self.id = id
        self.name = name
        self.character = character
        self.order = order
        self.profileURLString = profileURLString
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, character, order
        case profileURLString = "profile_path"
    }
}

extension Cast: Decodable { }

extension Cast: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Cast, rhs: Cast) -> Bool {
        lhs.id == rhs.id
    }
}
