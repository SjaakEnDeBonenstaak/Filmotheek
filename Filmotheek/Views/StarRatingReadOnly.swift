import SwiftUI

struct StarRatingReadOnly: View {
    let rating: Int
    var maxRating: Int = 5

    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...maxRating, id: \.self) { star in
                Image(systemName: star <= rating ? "star.fill" : "star")
                    .foregroundStyle(star <= rating ? .yellow : .gray)
                    .font(.caption)
            }
        }
    }
}
