//
//  MovieType.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 11.09.23.
//

import Foundation

enum MediaResultType: CaseIterable {
    case popular
    case trending
    case upcoming
    case topRated
    
    var title: String {
        switch self {
        case .popular: return "Popular"
        case .trending: return "Trending"
        case .upcoming: return "Upcoming"
        case .topRated: return "Top Rated"
        }
    }
    
    var symbolIcon: String {
        switch self {
        case .popular: return "flame"
        case .trending: return "chart.bar"
        case .upcoming: return "calendar.badge.clock"
        case .topRated: return "star.square.fill"
        }
    }
}
