import Foundation
import Observation

@Observable final class CollectionViewModel {
    var sortOrder: SortOrder = .dateDescending

    enum SortOrder: String, CaseIterable, Identifiable {
        case dateDescending = "Nieuwste eerst"
        case dateAscending = "Oudste eerst"
        case ratingDescending = "Hoogste beoordeling"
        case titleAscending = "A–Z"

        var id: String { rawValue }
    }

    func sorted(_ movies: [WatchedMovie]) -> [WatchedMovie] {
        switch sortOrder {
        case .dateDescending:  return movies.sorted { $0.watchedDate > $1.watchedDate }
        case .dateAscending:   return movies.sorted { $0.watchedDate < $1.watchedDate }
        case .ratingDescending: return movies.sorted { $0.rating > $1.rating }
        case .titleAscending:  return movies.sorted { $0.title.localizedCompare($1.title) == .orderedAscending }
        }
    }
}
