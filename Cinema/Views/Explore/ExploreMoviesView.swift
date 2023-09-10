//
//  ExploreMoviesView.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 10.09.23.
//

import SwiftUI

struct ExploreMoviesView: View {
    @EnvironmentObject var model: ExploreMoviesViewModel
    
    // MARK: Header Animation properties
    @State private var offsetY: CGFloat = 0
    @State private var showSearchBar = false
    
    var body: some View {
        GeometryReader { proxy in
            let safeTopArea = proxy.safeAreaInsets.top
            ScrollView(showsIndicators: false) {
                VStack {
                    headerView(safeTopArea)
                        .offset(y: -offsetY)
                        .zIndex(1)
                    
                    // Scrollable content goes here
                    VStack {
                        ForEach(1...10, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.blue.gradient)
                                .frame(height: 220)
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
        }
    }
    
    @ViewBuilder
    func headerView(_ safeTopArea: CGFloat) -> some View {
        // Reduced header height will be 80
        let progress = -(offsetY / 80) > 1 ? -1 : (offsetY > 0 ? 0 : (offsetY / 80))
        VStack(spacing: 15) {
            HStack(spacing: 15) {
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                    TextField("Search", text: .constant(""))
                        .tint(.white)
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
            HStack {
                customButton(symbolImage: "rectangle.portrait.and.arrow.forward", title: "Deposit") {
                    
                }
                customButton(symbolImage: "dollarsign", title: "Withdraw") {
                    
                }
                customButton(symbolImage: "qrcode", title: "Code") {
                    
                }
                customButton(symbolImage: "qrcode.viewfinder", title: "Scanning") {
                    
                }
            }
            // Shrinking horizontal spacing
            .padding(.horizontal, -progress * 50)
            .padding(.top, 10)
            // MARK: Moving up when scrolling started
            .offset(y: progress * 65)
            .opacity(showSearchBar ? 0 : 1)
        }
        // MARK: Displaying search button
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
        .padding(.top, safeTopArea + 10)
        .background {
            Rectangle().fill(Color.red.gradient).padding(.bottom, -progress * 85)
                
        }
    }
    
    @ViewBuilder
    func customButton(symbolImage: String, title: String, onClick: @escaping () -> Void) -> some View {
        // Fading out sooner than navigation bar animation
        let progress = -(offsetY / 40) > 1 ? -1 : (offsetY > 0 ? 0 : (offsetY / 40))
        Button {
            
        } label: {
            VStack {
                Image(systemName: symbolImage)
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
                    .frame(width: 35, height: 35)
                    .background {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(.white)
                    }
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .opacity(1 + progress)
            // Displaying alternative icon
            .overlay {
                Image(systemName: symbolImage)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .opacity(-progress)
                    .offset(y: -10)
            }
        }

    }
}

struct ExploreMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreMoviesView()
            .environmentObject(ExploreMoviesViewModel(tmdb: DummyTMDBService()))
    }
}

/// MARK: Offset key preference
struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

/// Offset View Extension
extension View {
    @ViewBuilder
    func offset(coordinateSpace: CoordinateSpace, completion: @escaping (CGFloat) -> Void) -> some View {
        self
            .overlay {
                GeometryReader { proxy in
                    let minY = proxy.frame(in: coordinateSpace).minY
                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                        .onPreferenceChange(OffsetKey.self) { completion($0) }
                }
            }
    }
}
