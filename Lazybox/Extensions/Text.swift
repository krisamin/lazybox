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
//  Created : 9/26/24
//  Package : Lazybox
//  File    : Text.swift
//

import SwiftUI

enum FontWantedSansType: String {
    case regular = "WantedSans-Regular"
    case medium = "WantedSans-Medium"
    case semibold = "WantedSans-SemiBold"
    case bold = "WantedSans-Bold"
}

extension Font {
    static func system(size: CGFloat, weight: FontWantedSansType = .regular) -> Font {
        custom(weight.rawValue, size: size)
    }
}
