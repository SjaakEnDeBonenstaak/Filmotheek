import Foundation
import Observation

@Observable final class SearchViewModel {
    var searchText: String = ""
    var movies: [TMDBMovie] = []
    var genres: [TMDBGenre] = []
    var selectedGenreID: Int? = nil
    var isLoading: Bool = false
    var errorMessage: String? = nil

    private var searchTask: Task<Void, Never>?

    var filteredMovies: [TMDBMovie] {
        guard let genreID = selectedGenreID else { return movies }
        return movies.filter { $0.genreIDs?.contains(genreID) == true }
    }

    init() {
        Task { await loadInitialData() }
    }

    @MainActor
    func loadInitialData() async {
        errorMessage = nil

        // Load from cache first for instant display
        if let cached = TMDBService.shared.loadCachedMovies() {
            movies = cached
        } else {
            isLoading = true
        }

        // Fetch genres and fresh popular movies in parallel
        async let genresTask = TMDBService.shared.fetchGenres()
        async let moviesTask = TMDBService.shared.fetchPopularMovies()

        do {
            genres = try await genresTask
            movies = try await moviesTask
        } catch {
            if movies.isEmpty {
                errorMessage = error.localizedDescription
            }
        }
        isLoading = false
    }

    @MainActor
    func onSearchTextChanged() {
        searchTask?.cancel()

        guard !searchText.isEmpty else {
            Task { await loadPopularMovies() }
            return
        }

        searchTask = Task {
            do {
                // 400ms debounce
                try await Task.sleep(nanoseconds: 400_000_000)
                guard !Task.isCancelled else { return }
                isLoading = true
                errorMessage = nil
                movies = try await TMDBService.shared.searchMovies(query: searchText)
                isLoading = false
            } catch is CancellationError {
                // Debounced — intentional
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
    }

    @MainActor
    private func loadPopularMovies() async {
        isLoading = true
        errorMessage = nil
        do {
            movies = try await TMDBService.shared.fetchPopularMovies()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
