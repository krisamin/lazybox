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
//  File    : Box.swift
//

import SwiftUI

struct Box<Content: View>: View {
    let padding: Bool
    let square: Bool
    @ViewBuilder let content: () -> Content

    init(
        padding: Bool = true,
        square: Bool = false,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.padding = padding
        self.square = square
        self.content = content
    }

    var body: some View {
        VStack(spacing: 0) {
            content()
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .aspectRatio(square ? 1 : nil, contentMode: square ? .fit : .fill)
        .padding(padding ? 12 : 1)
        .background(Color("Card"))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color("Border"), lineWidth: 1)
        )
    }
}
