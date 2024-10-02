//
//  ContentView.swift
//  Lazybox
//
//  Created by noViceMin on 9/26/24.
//

import SwiftUI
import MasonryStack

struct ContentView: View {
    @State private var tabSelection = 1

    var body: some View {
        TabView(selection: $tabSelection) {
            SettingsView()
                .tag(0)
            HomeView()
                .tag(1)
            NewView()
                .tag(2)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .sensoryFeedback(.selection, trigger: tabSelection)
        .ignoresSafeArea()
    }
}

struct NavbarItem: View {
    let title: String
    let selected: Bool

    var body: some View {
        Text(title)
            .font(.system(size: 28, weight: .medium))
            .foregroundStyle(selected ? Color("Text") : Color("Dim"))
    }
}

#Preview {
    let preview = Preview(Link.self)

    ContentView()
        .modelContainer(preview.container)
}
