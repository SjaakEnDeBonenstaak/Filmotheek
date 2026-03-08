import SwiftUI
import SwiftData

struct MovieDetailView: View {
    let movie: TMDBMovie

    @State private var viewModel = MovieDetailViewModel()
    @Environment(\.modelContext) private var modelContext
    @Query private var allWatched: [WatchedMovie]

    @State private var draftRating: Int = 3
    @State private var draftComment: String = ""
    @State private var showingSaveConfirmation: Bool = false

    private var watchedMovie: WatchedMovie? {
        allWatched.first(where: { $0.tmdbID == movie.id })
    }

    private var isWatched: Bool { watchedMovie != nil }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                headerSection
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding()
                } else if let detail = viewModel.detail {
                    detailSection(detail: detail)
                    castSection
                } else if let error = viewModel.errorMessage {
                    errorSection(message: error)
                }
                watchSection
            }
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                ShareLink(
                    item: "https://www.themoviedb.org/movie/\(movie.id)",
                    subject: Text(movie.title),
                    message: Text("Bekijk \(movie.title) op TMDB")
                )
            }
        }
        .task(id: movie.id) {
            await viewModel.load(movieID: movie.id)
        }
        .onChange(of: movie.id) {
            draftRating = watchedMovie?.rating ?? 3
            draftComment = watchedMovie?.comment ?? ""
        }
        .onAppear {
            if let watched = watchedMovie {
                draftRating = watched.rating
                draftComment = watched.comment
            }
        }
        .overlay {
            if showingSaveConfirmation {
                savedToast
            }
        }
    }

    // MARK: - Header

    private var headerSection: some View {
        HStack(alignment: .top, spacing: 16) {
            posterView
            VStack(alignment: .leading, spacing: 6) {
                Text(movie.title)
                    .font(.title2.bold())
                Text(movie.releaseYear)
                    .foregroundStyle(.secondary)
                if let detail = viewModel.detail {
                    Text(detail.runtimeFormatted)
                        .foregroundStyle(.secondary)
                    if !detail.genreNames.isEmpty {
                        Text(detail.genreNames)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    if let rating = detail.voteAverage {
                        Label(String(format: "%.1f / 10", rating), systemImage: "star.fill")
                            .foregroundStyle(.orange)
                            .font(.subheadline)
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top)
    }

    private var posterView: some View {
        PosterImageView(url: movie.posterURL, width: 100, height: 150, cornerRadius: 10)
            .shadow(radius: 4)
    }

    // MARK: - Detail

    private func detailSection(detail: TMDBMovieDetail) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            if let tagline = detail.tagline, !tagline.isEmpty {
                Text(tagline)
                    .font(.subheadline.italic())
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
            }
            if !detail.overview.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Verhaal")
                        .font(.headline)
                    Text(detail.overview)
                        .font(.body)
                        .foregroundStyle(.primary)
                }
                .padding(.horizontal)
            }
        }
    }

    // MARK: - Cast

    private var castSection: some View {
        Group {
            if !viewModel.cast.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Cast")
                        .font(.headline)
                        .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(viewModel.cast) { member in
                                castCard(member: member)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }

    private func castCard(member: TMDBCastMember) -> some View {
        VStack(spacing: 4) {
            Group {
                if let url = member.profileURL {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let img): img.resizable().aspectRatio(contentMode: .fill)
                        default: Circle().fill(Color.secondary.opacity(0.2))
                        }
                    }
                } else {
                    Circle().fill(Color.secondary.opacity(0.2))
                }
            }
            .frame(width: 64, height: 64)
            .clipShape(Circle())

            Text(member.name)
                .font(.caption2.bold())
                .lineLimit(2)
                .multilineTextAlignment(.center)
            Text(member.character)
                .font(.caption2)
                .foregroundStyle(.secondary)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
        .frame(width: 72)
    }

    // MARK: - Error

    private func errorSection(message: String) -> some View {
        Label(message, systemImage: "exclamationmark.triangle")
            .foregroundStyle(.orange)
            .padding(.horizontal)
    }

    // MARK: - Watch / Rate section

    private var watchSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Divider().padding(.horizontal)
            Text(isWatched ? "Jouw beoordeling" : "Markeer als bekeken")
                .font(.headline)
                .padding(.horizontal)

            VStack(alignment: .leading, spacing: 8) {
                StarRatingView(rating: $draftRating)
                    .padding(.horizontal)

                TextField("Opmerking (optioneel)", text: $draftComment, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(3...6)
                    .padding(.horizontal)

                Button(action: saveWatched) {
                    Label(
                        isWatched ? "Beoordeling bijwerken" : "Markeer als bekeken",
                        systemImage: isWatched ? "arrow.clockwise" : "checkmark.circle.fill"
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)

                if isWatched {
                    Button(role: .destructive, action: removeWatched) {
                        Label("Verwijder uit collectie", systemImage: "trash")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .padding(.horizontal)
                }
            }
        }
        .padding(.bottom)
    }

    // MARK: - Actions

    private func saveWatched() {
        let genreString = viewModel.detail?.genreNames ?? ""
        let overview = viewModel.detail?.overview ?? movie.overview

        if let existing = watchedMovie {
            existing.rating = draftRating
            existing.comment = draftComment
        } else {
            let entry = WatchedMovie(
                tmdbID: movie.id,
                title: movie.title,
                posterPath: movie.posterPath,
                releaseDate: movie.releaseDate,
                rating: draftRating,
                comment: draftComment,
                watchedDate: Date(),
                genreNames: genreString,
                overview: overview
            )
            modelContext.insert(entry)
        }

        showingSaveConfirmation = true
        Task {
            try? await Task.sleep(nanoseconds: 1_500_000_000)
            await MainActor.run { showingSaveConfirmation = false }
        }
    }

    private func removeWatched() {
        guard let watched = watchedMovie else { return }
        modelContext.delete(watched)
    }

    // MARK: - Toast

    private var savedToast: some View {
        VStack {
            Spacer()
            HStack {
                Image(systemName: "checkmark.circle.fill").foregroundStyle(.green)
                Text("Opgeslagen")
            }
            .padding()
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
            .padding(.bottom, 32)
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .animation(.spring, value: showingSaveConfirmation)
    }
}
