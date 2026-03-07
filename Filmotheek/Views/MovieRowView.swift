import SwiftUI

struct MovieRowView: View {
    let movie: TMDBMovie

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            posterImage
            movieInfo
            Spacer()
        }
        .padding(.vertical, 4)
    }

    private var posterImage: some View {
        Group {
            if let url = movie.posterURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        placeholderPoster
                    default:
                        ProgressView()
                    }
                }
            } else {
                placeholderPoster
            }
        }
        .frame(width: 56, height: 84)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }

    private var placeholderPoster: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(Color.secondary.opacity(0.2))
            .overlay(
                Image(systemName: "film")
                    .foregroundStyle(.secondary)
            )
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
            posterImage
            movieInfo
            Spacer()
        }
        .padding(.vertical, 4)
    }

    private var posterImage: some View {
        Group {
            if let url = movie.posterURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        placeholderPoster
                    default:
                        ProgressView()
                    }
                }
            } else {
                placeholderPoster
            }
        }
        .frame(width: 56, height: 84)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }

    private var placeholderPoster: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(Color.secondary.opacity(0.2))
            .overlay(
                Image(systemName: "film")
                    .foregroundStyle(.secondary)
            )
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
