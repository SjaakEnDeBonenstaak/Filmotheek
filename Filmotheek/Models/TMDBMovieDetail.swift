import Foundation

struct TMDBMovieDetail: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String?
    let runtime: Int?
    let tagline: String?
    let voteAverage: Double?
    let genres: [TMDBGenre]

    enum CodingKeys: String, CodingKey {
        case id, title, overview, runtime, tagline, genres
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }

    var releaseYear: String {
        guard let date = releaseDate, date.count >= 4 else { return "?" }
        return String(date.prefix(4))
    }

    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: TMDBService.imageBaseURL + path)
    }

    var runtimeFormatted: String {
        guard let mins = runtime, mins > 0 else { return "?" }
        let h = mins / 60
        let m = mins % 60
        return h > 0 ? "\(h)h \(m)m" : "\(m)m"
    }

    var genreNames: String {
        genres.map(\.name).joined(separator: ", ")
    }
}
