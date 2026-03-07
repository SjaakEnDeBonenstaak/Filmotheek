import Foundation

enum TMDBError: LocalizedError {
    case missingAPIKey
    case invalidURL
    case networkError(Error)
    case decodingError(Error)

    var errorDescription: String? {
        switch self {
        case .missingAPIKey:
            return "TMDB Read Access Token ontbreekt. Voeg TMDB_API_KEY toe aan Info.plist."
        case .invalidURL:
            return "Ongeldige URL."
        case .networkError(let e):
            return "Netwerkfout: \(e.localizedDescription)"
        case .decodingError(let e):
            return "Decodeerder: \(e.localizedDescription)"
        }
    }
}

final class TMDBService {
    static let shared = TMDBService()
    private init() {}

    private let baseURL = "https://api.themoviedb.org/3"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"

    private let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ODI0YzNlZGIwMzY3NTNhNjdmZDY5NmNhODIxMWJkZSIsIm5iZiI6MTc3Mjg4MDYyMC4yNjMsInN1YiI6IjY5YWMwMmVjZWFmM2U3Nzc1Mjc5ZjY4NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.wo5JPL6JQomk7a-90TG3evYkXdXTTuHgH4_GLxzTfy0"

    private let cacheFileName = "popular_movies_cache.json"

    private var cacheURL: URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            .first?.appendingPathComponent(cacheFileName)
    }

    // MARK: - Public API

    func loadCachedMovies() -> [TMDBMovie]? {
        guard let url = cacheURL,
              let data = try? Data(contentsOf: url),
              let response = try? JSONDecoder().decode(TMDBMovieResponse.self, from: data)
        else { return nil }
        return response.results
    }

    func fetchPopularMovies() async throws -> [TMDBMovie] {
        let urlString = "\(baseURL)/movie/popular?page=1"
        guard let url = URL(string: urlString) else { throw TMDBError.invalidURL }
        let data = try await fetch(url: url)
        saveCache(data: data)
        let response = try decode(TMDBMovieResponse.self, from: data)
        return response.results
    }

    func searchMovies(query: String) async throws -> [TMDBMovie] {
        guard let encoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw TMDBError.invalidURL
        }
        let urlString = "\(baseURL)/search/movie?query=\(encoded)&page=1"
        guard let url = URL(string: urlString) else { throw TMDBError.invalidURL }
        let data = try await fetch(url: url)
        let response = try decode(TMDBMovieResponse.self, from: data)
        return response.results
    }

    func fetchMovieDetail(id: Int) async throws -> TMDBMovieDetail {
        let urlString = "\(baseURL)/movie/\(id)"
        guard let url = URL(string: urlString) else { throw TMDBError.invalidURL }
        let data = try await fetch(url: url)
        return try decode(TMDBMovieDetail.self, from: data)
    }

    func fetchCredits(id: Int) async throws -> TMDBCredits {
        let urlString = "\(baseURL)/movie/\(id)/credits"
        guard let url = URL(string: urlString) else { throw TMDBError.invalidURL }
        let data = try await fetch(url: url)
        return try decode(TMDBCredits.self, from: data)
    }

    func fetchGenres() async throws -> [TMDBGenre] {
        let urlString = "\(baseURL)/genre/movie/list"
        guard let url = URL(string: urlString) else { throw TMDBError.invalidURL }
        let data = try await fetch(url: url)
        let response = try decode(TMDBGenreResponse.self, from: data)
        return response.genres
    }

    // MARK: - Private helpers

    private func fetch(url: URL) async throws -> Data {
        guard !accessToken.isEmpty else { throw TMDBError.missingAPIKey }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return data
        } catch {
            throw TMDBError.networkError(error)
        }
    }

    private func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            throw TMDBError.decodingError(error)
        }
    }

    private func saveCache(data: Data) {
        guard let url = cacheURL else { return }
        try? data.write(to: url)
    }
}
