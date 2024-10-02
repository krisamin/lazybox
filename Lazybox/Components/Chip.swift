//
//  Chip.swift
//  Lazybox
//
//  Created by noViceMin on 10/2/24.
//

import SwiftUI

struct Chip: View {
    let title: String
    let filled: Bool
    let fill: Bool

    init(title: String, filled: Bool, fill: Bool = false) {
        self.title = title
        self.filled = filled
        self.fill = fill
    }

    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(
                    filled ? Color("Background") : Color("Text")
                )
                .lineLimit(1)
                .frame(maxWidth: fill ? .infinity : nil, alignment: .leading)
        }
        .padding([.horizontal], 16)
        .padding([.vertical], 12)
        .background(
            filled ? Color("Text") : Color("Card")
        )
        .cornerRadius(22)
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .inset(by: 0.5)
                .stroke(
                    filled ? Color("Text") : Color("Border"),
                    lineWidth: 1
                )
        )
    }
}
