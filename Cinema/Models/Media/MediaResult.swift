//
//  MediaResult.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 07.09.23.
//

import Foundation

struct MediaResult: Decodable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    var results: [Media]
    
    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case page, results
    }
}
