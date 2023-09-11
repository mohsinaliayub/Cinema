//
//  ContentView.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 07.09.23.
//

import SwiftUI

struct ContentView: View {
    @Namespace private var animation
    @State private var showingDetail = false
    @State private var selectedTab = 0
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                DashboardView(animation: animation)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .tag(0)
                
                ExploreMoviesView(animation: animation)
                    .tabItem {
                        Label("Explore", systemImage: "magnifyingglass")
                    }
                    .tag(1)
            }
            
            
        }
//        ExploreMoviesView(animation: animation)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DashboardViewModel(tmdb: DummyTMDBService()))
    }
}
