//
//  ExploreMoviesView.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 10.09.23.
//

import SwiftUI

struct ExploreMoviesView: View {
    @EnvironmentObject var model: ExploreMoviesViewModel
    var animation: Namespace.ID
    
    // MARK: Header Animation properties
    @State private var offsetY: CGFloat = 0
    @State private var showSearchBar = false
    @State private var activeTab: MovieType?
    
    var body: some View {
        GeometryReader { proxy in
            let safeTopArea = proxy.safeAreaInsets.top
            ScrollView(showsIndicators: false) {
                VStack {
                    SearchBarWithMovieTypeView(searchText: $model.searchText,
                                               showSearchBar: $showSearchBar,
                                               activeTab: $activeTab, offsetY: offsetY,
                                               topAreaInset: safeTopArea) {
                        Task {
                            do {
                                try await model.fetchMoviesBySearch()
                            } catch {
                                print(error)
                            }
                        }
                    }.offset(y: -offsetY).zIndex(1)
                    
                    // Scrollable content goes here
                    VStack {
                        ForEach(model.movies) { movie in
                            MediaCard(media: movie, showDetail: .constant(false), genres: model.fetchGenres(for: movie), animation: animation)
                        }
                    }
                    .padding(15)
                }
                .offset(coordinateSpace: .named("SCROLL")) { offset in
                    offsetY = offset
                    showSearchBar = (-offset > 80) && showSearchBar
                }
            }
            .coordinateSpace(name: "SCROLL")
            .edgesIgnoringSafeArea(.top)
            .task {
                activeTab = .trending
                
                do {
                    try await model.fetchData()
//                    try await model.fetchMoviesByType(.trending)
                } catch { }
            }
        }
    }    
}

struct ExploreMoviesView_Previews: PreviewProvider {
    @Namespace static var animation
    static var previews: some View {
        ExploreMoviesView(animation: animation)
            .environmentObject(ExploreMoviesViewModel(tmdb: DummyTMDBService()))
    }
}
