//
//  CinemaApp.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 07.09.23.
//

import SwiftUI

@main
struct CinemaApp: App {
    private let tmdb: TMDB = TMDBService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DashboardViewModel(tmdb: tmdb))
        }
    }
}
