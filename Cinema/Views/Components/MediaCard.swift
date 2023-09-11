//
//  MediaCard.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 11.09.23.
//

import SwiftUI
import NukeUI

struct MediaCard: View {
    let media: Media
    @Binding var showDetail: Bool
    var genres: [Genre]
    var animation: Namespace.ID
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if !showDetail {
                ZStack {
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
                        GenresView(genres: fetchGenres(for: media))
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
    
    func fetchGenres(for media: Media) -> [Genre] {
        guard !genres.isEmpty else { return [] }
        
        var genres = [Genre]()
        media.genreIds.forEach { genreId in
            if let genre = fetchGenre(byId: genreId) {
                genres.append(genre)
            }
        }
        return genres
    }
    
    private func fetchGenre(byId id: Int) -> Genre? {
        genres.first { $0.id == id }
    }
}
