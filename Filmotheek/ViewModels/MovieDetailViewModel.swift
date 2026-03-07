import Foundation
import Observation

@Observable final class MovieDetailViewModel {
    var detail: TMDBMovieDetail? = nil
    var cast: [TMDBCastMember] = []
    var isLoading: Bool = false
    var errorMessage: String? = nil

    @MainActor
    func load(movieID: Int) async {
        isLoading = true
        errorMessage = nil

        async let detailTask = TMDBService.shared.fetchMovieDetail(id: movieID)
        async let creditsTask = TMDBService.shared.fetchCredits(id: movieID)

        do {
            detail = try await detailTask
            cast = Array((try await creditsTask).cast.prefix(10))
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
