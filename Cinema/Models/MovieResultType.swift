//
//  MovieType.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 11.09.23.
//

import Foundation

enum MovieResultType: String, CaseIterable, Identifiable {
    var id: Int {
        switch self {
        case .nowPlaying: return 0
        case .topRated: return 1
        }
    }
    case nowPlaying = "Now Showing"
    case topRated = "Top Rated"
}
