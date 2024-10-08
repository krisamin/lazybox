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
//  Created : 10/3/24
//  Package : Lazybox
//  File    : ActionButton.swift
//

import SwiftUI

struct ActionButton: View {
    let title: String
    let symbol: String
    let fill: Bool
    let action: (() -> Void)?

    init(
        title: String,
        symbol: String,
        fill: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.symbol = symbol
        self.fill = fill
        self.action = action
    }

    var body: some View {
        Button(
            action: {
                action?()
            },
            label: {
                Box {
                    HStack(spacing: 12) {
                        Image(symbol)
                        if fill {
                            Spacer()
                        }
                        Text(title)
                            .font(.system(size: 16))
                    }
                    .frame(maxWidth: fill ? .infinity : nil, alignment: .leading)
                }
            }
        )
    }
}
