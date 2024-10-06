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
//  Created : 10/5/24
//  Package : Lazybox
//  File    : Section.swift
//

import SwiftUI

struct Section<Content: View>: View {
    let title: String
    let symbol: String
    let actionSymbol: String
    @MainActor let action: () -> Void
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(spacing: 0) {
            SectionTitle(title: title, symbol: symbol, actionSymbol: actionSymbol, action: action)
            content()
            SectionFooter(title: "Show All", symbol: "More")
        }
        .padding([.vertical], 6)
    }
}
