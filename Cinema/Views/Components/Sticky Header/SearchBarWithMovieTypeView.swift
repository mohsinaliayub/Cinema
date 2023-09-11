//
//  SearchBarWithMovieTypeView.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 10.09.23.
//

import SwiftUI

struct SearchBarWithMovieTypeView: View {
    @Binding var searchText: String
    @Binding var showSearchBar: Bool
//    @Binding var activeTab: MediaResultType?
    var offsetY: CGFloat
    let topAreaInset: CGFloat
    var performSearch: () -> Void
    
    var body: some View {
        // Reduced header height will be 80
        headerView()
    }
    
    @ViewBuilder
    func headerView() -> some View {
        let progress = -(offsetY / 80) > 1 ? -1 : (offsetY > 0 ? 0 : (offsetY / 80))
        VStack(spacing: 15) {
            HStack(spacing: 15) {
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
                .opacity(showSearchBar ? 1 : 1 + progress)
                
                // Displaying XMark button
                if showSearchBar {
                    Button {
                        showSearchBar = false
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title3)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                }

            }
//            HStack {
//                ForEach(MediaResultType.allCases, id: \.self) { type in
//                    customButton(type: type) {
//
//                    }
//                }
//            }
            // Shrinking horizontal spacing
            .padding(.horizontal, -progress * 50)
            .padding(.top, 10)
            // MARK: Moving up when scrolling started
            .offset(y: progress * 65)
            .opacity(showSearchBar ? 0 : 1)
        }
        .overlay(alignment: .topLeading, content: {
            Button {
                showSearchBar = true
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .offset(x: 13, y: 10)
            .opacity(showSearchBar ? 0 : -progress)
        })
        .animation(.easeInOut(duration: 0.2), value: showSearchBar)
        .environment(\.colorScheme, .dark)
        .padding([.horizontal, .bottom], 15)
        .padding(.top, topAreaInset + 10)
        .background {
            Rectangle().fill(Color.red.gradient).padding(.bottom, -progress * 85)
        }
    }
    
    // MARK:  Custom Button with Symbol
//    @ViewBuilder
//    func customButton(symbolIcon: String, title: String, onClick: @escaping () -> Void) -> some View {
//        // Fading out sooner than navigation bar animation
//        let progress = -(offsetY / 40) > 1 ? -1 : (offsetY > 0 ? 0 : (offsetY / 40))
//        Button {
////            activeTab = type
//        } label: {
//            VStack {
//                Image(systemName: symbolIcon)
//                    .fontWeight(.semibold)
//                    .foregroundColor(.red)
//                    .frame(width: 35, height: 35)
//                    .background {
//                        RoundedRectangle(cornerRadius: 8, style: .continuous)
//                            .fill(foregroundColor(type: type))
//                    }
//                Text(title)
//                    .font(.caption)
//                    .fontWeight(.semibold)
//                    .lineLimit(1)
//                    .foregroundColor(foregroundColor(type: type))
//            }
//            .frame(maxWidth: .infinity)
//            .opacity(1 + progress)
//            // Displaying alternative icon
//            .overlay {
//                Image(systemName: symbolIcon)
//                    .font(.title3)
//                    .fontWeight(.semibold)
//                    .foregroundColor(foregroundColor(type: type))
//                    .opacity(-progress)
//                    .offset(y: -10)
//            }
//        }
//    }
    
//    func foregroundColor(type: MediaResultType) -> Color {
//        withAnimation(.easeInOut) {
//            activeTab == type ? .white : AppColors.castBackground.opacity(0.5)
//        }
//    }
}


//struct SearchBarWithMovieTypeView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBarWithMovieTypeView(searchText: .constant(""), showSearchBar: .constant(false), activeTab: .constant(MediaResultType.trending), offsetY: 0, topAreaInset: 48) { }
//    }
//}
