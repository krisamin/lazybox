//
//  ContentView.swift
//  Lazybox
//
//  Created by noViceMin on 9/26/24.
//

import SwiftUI
import MasonryStack

struct ContentView: View {
    @State private var tabSelection = 0

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $tabSelection) {
                HomeView()
                    .tag(0)
                SettingsView()
                    .tag(1)
                NewView()
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()
            .onAppear {
                  UIScrollView.appearance().isScrollEnabled = false
            }
            HStack(spacing: 24) {
                NavbarItem(title: "box", selected: tabSelection == 0)
                    .onTapGesture {
                        tabSelection = 0
                    }
                Spacer()
                NavbarItem(title: "settings", selected: tabSelection == 1)
                    .onTapGesture {
                        tabSelection = 1
                    }
                NavbarItem(title: "new", selected: tabSelection == 2)
                    .onTapGesture {
                        tabSelection = 2
                    }
            }
            .padding(6)
            .sensoryFeedback(.selection, trigger: tabSelection)
        }
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
