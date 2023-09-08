//
//  Constants.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 07.09.23.
//

import SwiftUI

public enum Constants {
    public enum APIConstants {
        /// Cinematic API Key (v3).
        public static let apiKey = ""
        /// Base URL for all the queries against The Movie DB API, except for images.
        public static let baseURL = "https://api.themoviedb.org/3"
        /// Base URL for image requests.
        public static let baseURLForImages = "https://image.tmdb.org/t/p/original"
    }
}

public enum AppColors {
    public static let castBackground = Color("swatch3")
    public static let reviewCardBackground = Color("swatch6")
}
