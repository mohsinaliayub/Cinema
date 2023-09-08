//
//  CastView.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 08.09.23.
//

import SwiftUI
import NukeUI

struct CastView: View {
    @Binding var cast: [Cast]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Cast").font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .firstTextBaseline) {
                    ForEach(cast) { cast in
                        VStack(alignment: .leading, spacing: 4) {
                            LazyImage(source: cast.profilePictureURL)
                                .frame(height: 100)
                                .cornerRadius(5)
                            Text(cast.name).font(.caption.bold())
                                .lineLimit(1)
                            Text(cast.character).font(.caption2)
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                        }
                        .frame(width: 100)
                    }
                }
            }
        }
    }
}

struct CastView_Previews: PreviewProvider {
    static var previews: some View {
        CastView(cast: .constant(DummyTMDBService().cast))
    }
}
