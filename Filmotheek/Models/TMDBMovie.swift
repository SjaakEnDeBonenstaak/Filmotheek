import Foundation

struct TMDBMovie: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double?
    let genreIDs: [Int]?

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case genreIDs = "genre_ids"
    }

    var releaseYear: String {
        guard let date = releaseDate, date.count >= 4 else { return "?" }
        return String(date.prefix(4))
    }

    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: TMDBService.imageBaseURL + path)
    }
}

struct TMDBMovieResponse: Codable {
    let results: [TMDBMovie]
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
    }
}
