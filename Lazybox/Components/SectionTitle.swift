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
//  File    : SectionTitle.swift
//

import SwiftUI

struct SectionTitle: View {
    let title: String
    let symbol: String
    let actionSymbol: String
    let action: () -> Void

    var body: some View {
        HStack(spacing: 24) {
            HStack(spacing: 12) {
                Image(symbol)
                Text(title)
                    .font(.system(size: 24))
            }
            Rectangle()
                .fill(Color("Border"))
                .frame(height: 1)
            Image(actionSymbol)
                .onTapGesture {
                    action()
                }
        }
        .padding([.horizontal], 12)
        .padding([.vertical], 6)
    }
}
