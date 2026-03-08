import SwiftUI

struct SearchView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var viewModel = SearchViewModel()
    @State private var selectedMovie: TMDBMovie?

    var body: some View {
        AdaptiveNavigationView(title: "Zoeken") {
            listContent
                .navigationDestination(for: TMDBMovie.self) { movie in
                    MovieDetailView(movie: movie)
                }
        } detail: {
            if let movie = selectedMovie {
                MovieDetailView(movie: movie)
            } else {
                ContentUnavailableView(
                    "Selecteer een film",
                    systemImage: "film",
                    description: Text("Kies een film uit de lijst")
                )
            }
        }
    }

    // MARK: - Shared list content

    private var listContent: some View {
        Group {
            if viewModel.isLoading && viewModel.movies.isEmpty {
                ProgressView("Laden…")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = viewModel.errorMessage, viewModel.movies.isEmpty {
                ContentUnavailableView(
                    "Fout",
                    systemImage: "exclamationmark.triangle",
                    description: Text(error)
                )
            } else {
                movieList
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Zoek een film…")
        .onChange(of: viewModel.searchText) {
            viewModel.onSearchTextChanged()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if viewModel.isLoading { ProgressView() }
            }
        }
    }

    // MARK: - Movie list

    private var movieList: some View {
        List {
            genreFilterRow
            ForEach(viewModel.filteredMovies) { movie in
                movieRow(for: movie)
            }
        }
        .listStyle(.plain)
    }

    @ViewBuilder
    private func movieRow(for movie: TMDBMovie) -> some View {
        if horizontalSizeClass == .regular {
            Button {
                selectedMovie = movie
            } label: {
                MovieRowView(movie: movie)
            }
            .buttonStyle(.plain)
            .listRowBackground(
                selectedMovie?.id == movie.id
                    ? Color.accentColor.opacity(0.12)
                    : Color.clear
            )
        } else {
            NavigationLink(value: movie) {
                MovieRowView(movie: movie)
            }
        }
    }

    // MARK: - Genre filter

    @ViewBuilder
    private var genreFilterRow: some View {
        if !viewModel.genres.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    genreChip(label: "Alle", id: nil)
                    ForEach(viewModel.genres) { genre in
                        genreChip(label: genre.name, id: genre.id)
                    }
                }
                .padding(.vertical, 6)
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .listRowSeparator(.hidden)
        }
    }

    private func genreChip(label: String, id: Int?) -> some View {
        let selected = viewModel.selectedGenreID == id
        return Button {
            viewModel.selectedGenreID = id
        } label: {
            Text(label)
                .font(.caption.bold())
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(selected ? Color.accentColor : Color.secondary.opacity(0.15))
                .foregroundStyle(selected ? .white : .primary)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}
