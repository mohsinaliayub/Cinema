//
//  DashboardView.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 07.09.23.
//

import SwiftUI
import NukeUI

struct DashboardView: View {
    @EnvironmentObject var model: DashboardViewModel
    
    var body: some View {
        ZStack {
            List(model.popularMovies) { media in
                mediaCard(media)
                    .listRowSeparator(.hidden)
            }
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .task {
                guard model.popularMovies.isEmpty else { return }
                do {
                    try await model.fetchPopularMovies()
                } catch { }
            }
        }
    }
    
    @ViewBuilder
    func mediaCard(_ media: Media) -> some View {
        ZStack {
            LazyImage(source: media.posterURL)
            Rectangle()
                .fill(Color.secondary.opacity(0.8))
        }
        .frame(width: 340, height: 500)
        .cornerRadius(15)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(DashboardViewModel(tmdb: DummyTMDBService()))
    }
}
