//
//  HomeView.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 11.09.23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: HomeViewModel
    @State private var showDetail = false
    @State private var selectedMedia: Media?
    @Namespace var animation
    
    @State private var offsetY: CGFloat = 0
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        VStack {
                            headerView
                                .background(Color.white)
                                .padding(.horizontal, 8)
                        }
                        .zIndex(1)
                        .offset(y: -offsetY)
                        
                        VStack(spacing: 16) {
                            ForEach(model.movies) { movie in
                                MediaCard(media: movie, showDetail: $showDetail, genres: [], animation: animation)
                                    .onTapGesture {
                                        withAnimation(.easeInOut) {
                                            selectedMedia = movie; showDetail = true
                                        }
                                    }
                            }
                        }
                        .padding(.top)
                    }
                    .offset(coordinateSpace: .named("SCROLL")) { value in
                        offsetY = value
                    }
                }
                .coordinateSpace(name: "SCROLL")
                .edgesIgnoringSafeArea(.top)
                .padding(.top)
                .opacity(showDetail ? 0 : 1)
                
                if let selectedMedia, showDetail {
                    MovieDetailView(movie: selectedMedia, showDetail: $showDetail, animation: animation)
                        .environmentObject(MovieDetailViewModel(movie: selectedMedia, tmdb: model.tmdb))
                }
            }
            .task {
                do {
                    try await model.fetchData()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    var headerView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).fill(AppColors.castBackground)
            GeometryReader { proxy in
                HStack(spacing: 0) {
                    ForEach(MovieResultType.allCases, id: \.self) { type in
                        Text(type.rawValue)
                            .font(.headline.bold())
                            .foregroundColor(model.selectedResult == type ? .white : .gray)
                            .frame(width: proxy.size.width / 2, height: proxy.size.height)
                            .background {
                                if type == model.selectedResult {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(AppColors.selectedToggle)
                                        .matchedGeometryEffect(id: "ACTIVE", in: animation)
                                        .shadow(color: .gray.opacity(0.45), radius: 3, x: 3, y: 0)
                                }
                            }
                            .onTapGesture {
                                withAnimation {
                                    model.selectedResult = type
                                }
                            }
                    }
                }
            }
        }
        .frame(height: 50)
        .padding(.horizontal)
        .zIndex(1)
    }
    
}

struct SearchField: View {
    @Binding var searchText: String
    var performSearch: () -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white)
            TextField("Search", text: $searchText)
                .tint(.white)
                .onSubmit {
                    performSearch()
                }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.black)
                .opacity(0.15)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel(tmdb: DummyTMDBService()))
    }
}
