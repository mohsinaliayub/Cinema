//
//  TextWithCircleOverlay.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 08.09.23.
//

import SwiftUI

struct TextWithCircleOverlay: View {
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundStyle(.white)
            .font(.subheadline.bold())
            .padding()
            .background {
                Circle()
                    .fill(Color.white.opacity(0.50))
                    .padding(4)
                    .overlay {
                        Circle()
                            .stroke(Color.white.opacity(0.35))
                    }
            }
    }
}

struct TextWithCircleOverlay_Previews: PreviewProvider {
    static var previews: some View {
        TextWithCircleOverlay(text: "8.5")
            .preferredColorScheme(.dark)
    }
}
