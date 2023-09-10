//
//  Genre.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 07.09.23.
//

import Foundation

public struct Genre: Identifiable {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

extension Genre: Hashable {
    
}

extension Genre: Codable { }

struct GenreResult: Codable {
    let genres: [Genre]
}
