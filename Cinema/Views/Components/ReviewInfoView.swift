//
//  ReviewInfoView.swift
//  Cinema
//
//  Created by Mohsin Ali Ayub on 08.09.23.
//

import SwiftUI
import NukeUI

struct ReviewInfoView: View {
    let review: Review
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(review.content)
                .lineLimit(2)
                .kerning(1.5)
                .padding(.trailing)
            
            HStack {
                LazyImage(source: review.authorDetails.avatarURL)
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
                VStack(alignment: .leading, spacing: 4) {
                    Text(review.author)
                        .font(.callout.bold())
                    if let date = review.createdAt {
                        Text("Created at " + date.format("d MMM YYYY"))
                            .font(.caption)
                            .textCase(.uppercase)
                    }
                }
                .kerning(1.5)
                .lineLimit(1)
                Spacer()
            }
        }
        .padding()
        .background {
            Rectangle().fill(AppColors.reviewCardBackground.opacity(0.5))
        }
        .cornerRadius(10)
    }
}

struct ReviewInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewInfoView(review: DummyTMDBService().reviews[0])
    }
}
