//
//  ReviewResult.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 08.09.23.
//

import Foundation

struct ReviewResult: Decodable {
    let id: Int
    let page: Int
    let reviews: [Review]
    let totalResults: Int
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case id, page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case reviews = "results"
    }
}
