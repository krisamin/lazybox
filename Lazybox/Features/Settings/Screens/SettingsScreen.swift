//
//  SettingsScreen.swift
//  Lazybox
//
//  Created by noViceMin on 9/26/24.
//

import SwiftUI

struct SettingsScreen: View {
    @State private var selected = Settings.general.rawValue

    var body: some View {
        VStack(spacing: 10) {
            ScrollView {
            }
            .scrollIndicators(.hidden)
            Selector(keys: Settings.allCases.map { $0.rawValue }, selected: $selected)
        }
    }
}

enum Settings: String, CaseIterable {
    case general = "General"
    case appearance = "Appearance"
    case support = "Support"
    case advanced = "Advanced"
}
