import Foundation

struct TMDBGenre: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
}

struct TMDBGenreResponse: Codable {
    let genres: [TMDBGenre]
}
