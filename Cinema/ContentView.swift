//
//  ContentView.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 07.09.23.
//

import SwiftUI

struct ContentView: View {
    let tmdb: TMDB
    
    @Namespace private var animation
    @State private var showDetail = false
    @State private var selectedTab = 0
    @State private var selectedMedia: Media?
    
    var body: some View {
        ZStack {
            TabView {
                DashboardView(animation: animation, selectedMedia: $selectedMedia, showDetail: $showDetail) { media in
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)) {
                        selectedMedia = media; showDetail = true
                    }
                }
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                
                ExploreMoviesView(animation: animation)
                    .tabItem {
                        Label("Explore", systemImage: "magnifyingglass")
                    }
            }
            .opacity(showDetail ? 0 : 1)
            
            if let selectedMedia, showDetail {
                MovieDetailView(movie: selectedMedia, showDetail: $showDetail, animation: animation)
                    .environmentObject(MovieDetailViewModel(movie: selectedMedia, tmdb: tmdb))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(tmdb: DummyTMDBService())
    }
}
