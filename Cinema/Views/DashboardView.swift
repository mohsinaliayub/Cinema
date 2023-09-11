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
                    MediaCard(media: media, showDetail: $showDetail, genres: model.fetchGenres(for: media), animation: animation)
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)) {
                                selectedMedia = media; showDetail = true
                            }
                        }
                        .padding(.bottom, 8)
                }
            }
            .opacity(showDetail ? 0 : 1)
            
            if let selectedMedia, showDetail {
                MovieDetailView(movie: selectedMedia, showDetail: $showDetail, animation: animation)
                    .environmentObject(MovieDetailViewModel(movie: selectedMedia, tmdb: model.tmdb))
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
}

struct MediaCard: View {
    let media: Media
    @Binding var showDetail: Bool
    var genres: [Genre]
    var animation: Namespace.ID
    
    var body: some View {
        ZStack {
            if !showDetail {
                ZStack(alignment: .topLeading) {
                    LazyImage(source: media.backdropURL)
                        .matchedGeometryEffect(id: media.id, in: animation)
                        .overlay {
                            Rectangle()
                                .fill(Color.black.opacity(0.55))
                        }
                    VStack {
                        HStack {
                            TextWithCircleOverlay(text: String(format: "%.1f", media.imdbRating))
                                .matchedGeometryEffect(id: "\(media.id)RATING", in: animation)
                            Spacer()
                        }
                        VStack(spacing: 16) {
                            Text(media.title)
                                .font(.title.bold())
                                .matchedGeometryEffect(id: "\(media.id)TITLE", in: animation)
                                .multilineTextAlignment(.center)
                            Text(media.releaseDate(withFormat: "MMM YYYY") ?? "")
                                .fontWeight(.thin)
                        }
                        .padding(.top, 48)
                        Spacer()
                        GenresView(genres: genres)
                            .padding(.leading, 8)
                    }
                    .foregroundStyle(.white)
                    .padding()
                }
            }
        }
        .frame(width: 340, height: 450)
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
