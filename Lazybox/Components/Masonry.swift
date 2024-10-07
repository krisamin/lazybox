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
//  Created : 10/6/24
//  Package : Lazybox
//  File    : Masonry.swift
//

import MasonryStack
import SwiftUI

struct Masonry<Content: View>: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    @ViewBuilder let content: () -> Content

    @State private var columnCount: Int = 2

    var body: some View {
        MasonryVStack(
            columns: columnCount,
            spacing: 6
        ) {
            content()
        }
        .padding(6)
        .background(
            GeometryReader { (proxy) -> Color in
                DispatchQueue.main.async {
                    columnCount = horizontalSizeClass == .compact ? 2 : Int(round(Float(proxy.size.width) / 300.0))
                }
                return Color.clear
            }
        )
    }
}
