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
//  Created : 10/2/24
//  Package : Lazybox
//  File    : Chip.swift
//

import SwiftUI

struct Chip: View {
    let title: String
    let filled: Bool
    let fill: Bool

    init(
        title: String,
        filled: Bool = false,
        fill: Bool = false
    ) {
        self.title = title
        self.filled = filled
        self.fill = fill
    }

    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(
                    filled
                        ? Color("Background")
                        : Color("Text")
                )
                .lineLimit(1)
                .frame(maxWidth: fill ? .infinity : nil, alignment: .leading)
        }
        .padding([.horizontal], 16)
        .frame(height: 42)
        .background(
            filled
                ? Color("Text")
                : Color("Card")
        )
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color("Border"), lineWidth: 1)
        )
    }
}
