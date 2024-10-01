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
                    SelectorItem(key: key, isSelected: selected == key)
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

struct SelectorItem: View {
    let key: String
    let isSelected: Bool

    var body: some View {
        VStack {
            Text(key)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(isSelected ? Color("Background") : Color("Text"))
        }
        .padding([.horizontal], 16)
        .padding([.vertical], 12)
        .background(isSelected ? Color("Text") : Color("Card"))
        .cornerRadius(22)
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .inset(by: 0.5)
                .stroke(isSelected ? Color("Text") : Color("Border"), lineWidth: 1)
        )
    }
}
