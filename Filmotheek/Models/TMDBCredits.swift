import Foundation

struct TMDBCredits: Codable {
    let cast: [TMDBCastMember]
}

struct TMDBCastMember: Codable, Identifiable {
    let id: Int
    let name: String
    let character: String
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id, name, character
        case profilePath = "profile_path"
    }

    var profileURL: URL? {
        guard let path = profilePath else { return nil }
        return URL(string: TMDBService.imageBaseURL + path)
    }
}
