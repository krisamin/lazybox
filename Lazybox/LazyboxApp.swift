//
//  ██   ██ ██████  ██ ███████  █████  ███    ███ ██ ███    ██
//  ██  ██  ██   ██ ██ ██      ██   ██ ████  ████ ██ ████   ██
//  █████   ██████  ██ ███████ ███████ ██ ████ ██ ██ ██ ██  ██
//  ██  ██  ██   ██ ██      ██ ██   ██ ██  ██  ██ ██ ██  ██ ██
//  ██   ██ ██   ██ ██ ███████ ██   ██ ██      ██ ██ ██   ████
//
//  https://isamin.kr
//  https://github.com/krisamin
//
//  Created : 9/26/24
//  Package : Lazybox
//  File    : LazyboxApp.swift
//

import SwiftData
import SwiftUI

@main
struct LazyboxApp: App {
    let container: ModelContainer

    var body: some Scene {
        WindowGroup {
            ContentView()
                .background(Color("Background"))
        }
        .modelContainer(container)
    }

    init() {
        let schema = Schema([Link.self])
        let config = ModelConfiguration(
            "Lazybox",
            schema: schema,
            groupContainer: .identifier("group.kr.isamin.lazybox")
        )

        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not configure the container")
        }

        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
