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
//  File    : ContentView.swift
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    RecentsSection()
                    SpacesSection()
                    TagsSection()
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    let preview = Preview(Item.self)

    ContentView()
        .background(Color("Background"))
        .foregroundStyle(Color("Text"))
        .modelContainer(preview.container)
}
