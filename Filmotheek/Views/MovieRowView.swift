import SwiftUI

struct MovieRowView: View {
    let movie: TMDBMovie

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            PosterImageView(url: movie.posterURL, width: 56, height: 84, cornerRadius: 6)
            movieInfo
            Spacer()
        }
        .padding(.vertical, 4)
    }

    private var movieInfo: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(movie.title)
                .font(.headline)
                .lineLimit(2)
            Text(movie.releaseYear)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            if let rating = movie.voteAverage {
                Label(String(format: "%.1f", rating), systemImage: "star.fill")
                    .font(.caption)
                    .foregroundStyle(Color.appDark)
            }
        }
    }
}
