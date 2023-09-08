//
//  MovieDetailView.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 07.09.23.
//

import SwiftUI
import NukeUI
import SwiftUIDelayedGesture

struct MovieDetailView: View {
    let movie: Media
    @Binding var showDetail: Bool
    var animation: Namespace.ID
    
    @EnvironmentObject var model: MovieDetailViewModel
    
    @State private var scale: CGFloat = 1
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 8) {
                    ZStack(alignment: .top) {
                        LazyImage(source: movie.backdropURL)
                            .matchedGeometryEffect(id: movie.id, in: animation)
                            .frame(height: 450)
                            .overlay {
                                Rectangle().fill(Color.black.opacity(0.33))
                            }
                        
                        HStack {
                            TextWithCircleOverlay(text: "\(movie.imdbRating)")
                                .matchedGeometryEffect(id: "\(movie.id)RATING", in: animation)
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top, 48)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Synopsis")
                            .font(.headline)
                        Text(movie.overview)
                            .font(.caption)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    
                    if !model.cast.isEmpty {
                        CastView(cast: $model.cast)
                            .padding(.top, 8)
                            .padding(.horizontal)
                            .padding(.bottom)
                        .background(AppColors.castBackground)
                    }
                    
                    if !model.reviews.isEmpty {
                        VStack(alignment: .leading) {
                            Text("Reviews").font(.headline)
                            ForEach(model.reviews) { review in
                                ReviewInfoView(review: review)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                }
            }
            
            Button(action: {
                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)) {
                    showDetail = false
                }
            }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            .padding(.top, 48)
            .padding(.trailing)
        }
        .scaleEffect(scale)
        .edgesIgnoringSafeArea(.all)
        .task {
            do {
                try await model.fetchData()
            } catch { print(error.localizedDescription) }
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    @Namespace static var animation
    static var previews: some View {
        MovieDetailView(movie: DummyTMDBService().media[0], showDetail: .constant(true), animation: animation)
            .environmentObject(MovieDetailViewModel(movie: DummyTMDBService().media[0],
                                                    tmdb: DummyTMDBService()))
    }
}
