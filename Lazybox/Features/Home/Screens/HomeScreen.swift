//
//  HomeScreen.swift
//  Lazybox
//
//  Created by noViceMin on 9/26/24.
//

import SwiftUI
import MasonryStack

struct HomeScreen: View {
    @State private var selected = Categories.lazy.rawValue

    var body: some View {
        VStack(spacing: 10) {
            ScrollView {
                MasonryVStack(columns: 2, spacing: 10) {
                    ForEach(0..<100) { _ in
                        Color(
                            red: Double.random(in: 0.4...0.6),
                            green: Double.random(in: 0.4...0.6),
                            blue: Double.random(in: 0.4...0.6)
                        ).frame(height: CGFloat.random(in: 100...400))
                    }
                }
                .padding([.horizontal, .top], 10)
            }
            .scrollIndicators(.hidden)
            Selector(keys: Categories.allCases.map { $0.rawValue }, selected: $selected)
        }
    }
}

enum Categories: String, CaseIterable {
    case lazy = "Lazy"
    case links = "Links"
    case notes = "Notes"
}
