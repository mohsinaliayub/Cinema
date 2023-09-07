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
    var animation: Namespace.ID
    @State private var selectedMedia: Media?
    @State private var showDetail = false
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                ForEach(model.popularMovies) { media in
                    mediaCard(media)
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)) {
                                selectedMedia = media; showDetail = true
                            }
                        }
                        .padding(.bottom)
                }
            }
            .opacity(showDetail ? 0 : 1)
            
            if let selectedMedia, showDetail {
                MovieDetailView(movie: selectedMedia, showDetail: $showDetail, animation: animation)
            }
        }
        .task {
            guard model.popularMovies.isEmpty else { return }
            do {
                try await model.fetchData()
            } catch {
                print(error)
            }
        }
    }
    
    @ViewBuilder
    func mediaCard(_ media: Media) -> some View {
        ZStack {
            if !showDetail {
                LazyImage(source: media.posterURL)
                    .matchedGeometryEffect(id: media.id, in: animation)
                    .overlay {
                        Rectangle()
                            .fill(Color.secondary.opacity(0.8))
                    }
            }
        }
        .frame(width: 340, height: 500)
        .cornerRadius(15)
    }
}

struct DashboardView_Previews: PreviewProvider {
    @Namespace static var animation
    static var previews: some View {
        DashboardView(animation: animation)
            .environmentObject(DashboardViewModel(tmdb: DummyTMDBService()))
    }
}
