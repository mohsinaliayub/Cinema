//
//  URL+Extensions.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 07.09.23.
//

import Foundation

extension URLComponents {
    /// Maps a dictionary into `[URLQueryItem]` then assigns it to the
    /// `queryItems` property of this `URLComponents` instance.
    /// From [Alfian Losari's blog.](https://www.alfianlosari.com/posts/building-safe-url-in-swift-using-urlcomponents-and-urlqueryitem/)
    /// - Parameter parameters: Dictionary of query parameter names and values
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
    /// Adds a query item to the `queryItems` property.
    mutating func addQueryItem(withName name: String, andValue value: String) {
        self.queryItems?.append(URLQueryItem(name: name, value: value))
    }
}
