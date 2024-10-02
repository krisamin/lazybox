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
    let image: String

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16))
            Spacer()
            Image(image)
                .foregroundStyle(Color("Text"))
        }
        .padding(12)
        .background(Color("Card"))
        .cornerRadius(18)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .inset(by: 0.5)
                .stroke(Color("Border"), lineWidth: 1)
        )
    }
}
