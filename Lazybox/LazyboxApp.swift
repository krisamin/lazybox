//
//  LazyboxApp.swift
//  Lazybox
//
//  Created by noViceMin on 9/26/24.
//

import SwiftUI
import SwiftData

@main
struct LazyboxApp: App {
    let container: ModelContainer

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }

    init() {
        let schema = Schema([Link.self])
        let config = ModelConfiguration("Lazybox", schema: schema)

        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not configure the container")
        }

        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
