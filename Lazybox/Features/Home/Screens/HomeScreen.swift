//
//  HomeScreen.swift
//  Lazybox
//
//  Created by noViceMin on 9/26/24.
//

import SwiftUI
import MasonryStack

struct HomeScreen: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    @State private var selected = Categories.lazy.rawValue

    let randomColors = (1...100).map {_ in
        Color(
            red: Double.random(in: 0.4...0.6),
            green: Double.random(in: 0.4...0.6),
            blue: Double.random(in: 0.4...0.6)
        )
    }
    let randomHeights = (1...100).map { _ in CGFloat.random(in: 100...400) }

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 10) {
                ScrollView {
                    MasonryVStack(
                        columns: horizontalSizeClass == .compact ? 2 : Int(round(Float(proxy.size.width) / 300.0)),
                        spacing: 10
                    ) {
                        ForEach(0..<100, id: \.self) { index in
                            Rectangle()
                                .foregroundColor(randomColors[index])
                                .frame(height: randomHeights[index])
                        }
                    }
                    .padding([.horizontal, .top], 10)
                }
                .scrollIndicators(.hidden)
                Selector(keys: Categories.allCases.map { $0.rawValue }, selected: $selected)
            }
        }
    }
}

enum Categories: String, CaseIterable {
    case lazy = "Lazy"
    case links = "Links"
    case notes = "Notes"
}
