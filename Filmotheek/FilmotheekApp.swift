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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: WatchedMovie.self)
    }
}
