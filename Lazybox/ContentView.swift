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
        ScrollView {
            VStack(spacing: 24) {
                RecentsSection()
                Section(title: "Spaces", symbol: "Space", actionSymbol: "NewSpace", action: {}) {
                }
                Section(title: "Tags", symbol: "Tag", actionSymbol: "NewTag", action: {}) {
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    let preview = Preview(Item.self)

    ContentView()
        .background(Color("Background"))
        .foregroundStyle(Color("Text"))
        .modelContainer(preview.container)
}
