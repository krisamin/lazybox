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
import SwiftUIIntrospect

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
        .introspect(.navigationStack, on: .iOS(.v18)) {
            for controller in $0.viewControllers {
                controller.view.backgroundColor = .clear
            }
        }
        .background(Color("Background"))
        .foregroundStyle(Color("Text"))
    }
}

#Preview {
    let preview = Preview(Item.self)

    ContentView()
        .modelContainer(preview.container)
}
