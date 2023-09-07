//
//  MovieDetailView.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 07.09.23.
//

import SwiftUI
import NukeUI

struct MovieDetailView: View {
    let movie: Media
    @Binding var showDetail: Bool
    var animation: Namespace.ID
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ZStack(alignment: .top) {
                ScrollView(showsIndicators: false) {
                    VStack {
                        LazyImage(source: movie.backdropURL)
                            .matchedGeometryEffect(id: movie.id, in: animation)
                            .frame(height: 360)
                            .overlay {
                                Rectangle()
                                    .fill(Color.secondary.opacity(0.4))
                            }
                    }
                }
                .edgesIgnoringSafeArea(.all)
                
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)) {
                            showDetail = false
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
            }
            
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    @Namespace static var animation
    static var previews: some View {
        MovieDetailView(movie: DummyTMDBService().media[0], showDetail: .constant(true), animation: animation)
    }
}
