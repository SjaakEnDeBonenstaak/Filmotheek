import SwiftUI

struct WatchedMovieRowView: View {
    let watchedMovie: WatchedMovie

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            PosterImageView(url: watchedMovie.posterURL, width: 56, height: 84, cornerRadius: 6)
            movieInfo
            Spacer()
        }
        .padding(.vertical, 4)
    }

    private var movieInfo: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(watchedMovie.title)
                .font(.headline)
                .lineLimit(2)
            StarRatingReadOnly(rating: watchedMovie.rating)
            if !watchedMovie.comment.isEmpty {
                Text(watchedMovie.comment)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            Text(watchedMovie.watchedDate.formatted(date: .abbreviated, time: .omitted))
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
    }
}
