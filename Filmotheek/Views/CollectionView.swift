import SwiftUI
import SwiftData

struct CollectionView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.modelContext) private var modelContext
    @Query private var allWatched: [WatchedMovie]
    @State private var viewModel = CollectionViewModel()
    @State private var selectedWatched: WatchedMovie?

    private var sortedMovies: [WatchedMovie] {
        viewModel.sorted(allWatched)
    }

    var body: some View {
        AdaptiveNavigationView(title: "Collectie") {
            listContent
                .navigationDestination(for: WatchedMovie.self) { watched in
                    MovieDetailView(movie: watched.asTMDBMovie)
                }
        } detail: {
            if let watched = selectedWatched {
                MovieDetailView(movie: watched.asTMDBMovie)
            } else {
                ContentUnavailableView(
                    "Selecteer een film",
                    systemImage: "popcorn",
                    description: Text("Kies een film uit je collectie")
                )
            }
        }
    }

    // MARK: - List content

    private var listContent: some View {
        Group {
            if allWatched.isEmpty {
                ContentUnavailableView(
                    "Geen films",
                    systemImage: "popcorn",
                    description: Text("Markeer films als bekeken om ze hier te zien")
                )
            } else {
                List {
                    sortPicker
                    ForEach(sortedMovies) { movie in
                        movieRow(for: movie)
                    }
                    .onDelete(perform: deleteMovies)
                }
                .listStyle(.plain)
            }
        }
        .toolbar {
            if !allWatched.isEmpty {
                EditButton()
            }
        }
    }

    @ViewBuilder
    private func movieRow(for watched: WatchedMovie) -> some View {
        if horizontalSizeClass == .regular {
            Button {
                selectedWatched = watched
            } label: {
                WatchedMovieRowView(movie: watched)
            }
            .buttonStyle(.plain)
            .listRowBackground(
                selectedWatched?.tmdbID == watched.tmdbID
                    ? Color.accentColor.opacity(0.12)
                    : Color.clear
            )
        } else {
            NavigationLink(value: watched) {
                WatchedMovieRowView(movie: watched)
            }
        }
    }

    private var sortPicker: some View {
        Picker("Sorteren", selection: $viewModel.sortOrder) {
            ForEach(CollectionViewModel.SortOrder.allCases) { order in
                Text(order.rawValue).tag(order)
            }
        }
        .pickerStyle(.menu)
        .listRowSeparator(.hidden)
    }

    // MARK: - Helpers

    private func deleteMovies(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(sortedMovies[index])
        }
    }
}
