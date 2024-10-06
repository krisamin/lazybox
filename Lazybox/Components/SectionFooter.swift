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
//  File    : SectionFooter.swift
//

import SwiftUI

struct SectionFooter: View {
    let title: String
    let symbol: String

    var body: some View {
        HStack(spacing: 24) {
            Rectangle()
                .fill(Color("Border"))
                .frame(height: 1)
            HStack(spacing: 12) {
                Text(title)
                    .font(.system(size: 24))
                Image(symbol)
            }
        }
        .padding([.horizontal], 12)
        .padding([.vertical], 6)
    }
}
