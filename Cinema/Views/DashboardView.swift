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
    @Binding var selectedMedia: Media?
    @Binding var showDetail: Bool
    var onItemTap: (Media) -> Void
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(model.popularMovies) { media in
                    MediaCard(media: media, showDetail: $showDetail, genres: model.fetchGenres(for: media), animation: animation)
                        .onTapGesture {
                            onItemTap(media)
                        }
                        .padding(.bottom, 8)
                }
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

struct DashboardView_Previews: PreviewProvider {
    @Namespace static var animation
    static var previews: some View {
        DashboardView(animation: animation, selectedMedia: .constant(nil), showDetail: .constant(false)) { _ in }
            .environmentObject(DashboardViewModel(tmdb: DummyTMDBService()))
    }
}
