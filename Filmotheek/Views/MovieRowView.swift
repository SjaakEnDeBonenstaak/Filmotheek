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
                    .foregroundStyle(.orange)
            }
        }
    }
}

struct WatchedMovieRowView: View {
    let movie: WatchedMovie

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
            StarRatingReadOnly(rating: movie.rating)
            if !movie.comment.isEmpty {
                Text(movie.comment)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            Text(movie.watchedDate.formatted(date: .abbreviated, time: .omitted))
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
    }
}
