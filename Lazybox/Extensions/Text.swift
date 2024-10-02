//
//  Text.swift
//  Lazybox
//
//  Created by noViceMin on 9/26/24.
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
        self.custom(weight.rawValue, size: size)
    }
}
