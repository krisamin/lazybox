//
//  Selector.swift
//  Lazybox
//
//  Created by noViceMin on 9/26/24.
//

import SwiftUI

struct Selector: View {
    let keys: [String]
    @Binding var selected: String

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 6) {
                ForEach(keys, id: \.self) { key in
                    Chip(
                        title: key,
                        filled: selected == key
                    )
                    .onTapGesture {
                        selected = key
                    }
                }
            }
            .padding([.horizontal], 6)
        }
        .scrollIndicators(.hidden)
        .sensoryFeedback(.selection, trigger: selected)
    }
}
