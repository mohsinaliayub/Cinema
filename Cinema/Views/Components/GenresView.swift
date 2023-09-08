//
//  GenresView.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 08.09.23.
//

import SwiftUI

struct GenresView: View {
    var genres: [Genre]
    
    var body: some View {
        HStack {
            ForEach(genres.prefix(2)) { genre in
                Text(genre.name)
                    .font(.subheadline)
                    .textCase(.uppercase)
                    .background {
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(lineWidth: 1)
                            .padding(-8)
                    }
                    .padding(.trailing)
            }
            Spacer()
        }
    }
}

struct GenresView_Previews: PreviewProvider {
    static var previews: some View {
        GenresView(genres: DummyTMDBService().genres)
    }
}
