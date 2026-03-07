import Foundation
import SwiftData

@Model final class WatchedMovie {
    var tmdbID: Int
    var title: String
    var posterPath: String?
    var rating: Int
    var comment: String
    var watchedDate: Date
    var genreNames: String
    var overview: String

    init(
        tmdbID: Int,
        title: String,
        posterPath: String? = nil,
        rating: Int = 3,
        comment: String = "",
        watchedDate: Date = Date(),
        genreNames: String = "",
        overview: String = ""
    ) {
        self.tmdbID = tmdbID
        self.title = title
        self.posterPath = posterPath
        self.rating = rating
        self.comment = comment
        self.watchedDate = watchedDate
        self.genreNames = genreNames
        self.overview = overview
    }

    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500" + path)
    }
}
