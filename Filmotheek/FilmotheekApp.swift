//
//  FilmotheekApp.swift
//  Filmotheek
//
//  Created by lab on 07/03/2026.
//

import SwiftUI
import SwiftData

@main
struct FilmotheekApp: App {
    init() {
        // Search bar: olive cancel button + cursor, cream field background
        UISearchBar.appearance().tintColor = UIColor(
            red: 0.376, green: 0.424, blue: 0.220, alpha: 1
        )
        UISearchTextField.appearance(
            whenContainedInInstancesOf: [UISearchBar.self]
        ).backgroundColor = UIColor(
            red: 0.996, green: 0.980, blue: 0.878, alpha: 0.9
        )
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: WatchedMovie.self)
    }
}
