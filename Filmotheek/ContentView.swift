//
//  ContentView.swift
//  Filmotheek
//
//  Created by lab on 07/03/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Zoeken", systemImage: "magnifyingglass") {
                SearchView()
            }
            Tab("Collectie", systemImage: "film.stack") {
                CollectionView()
            }
        }
        .tint(.appPrimary)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: WatchedMovie.self, inMemory: true)
}
