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

    @State private var hapticTrigger = 0

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(keys, id: \.self) { key in
                    SelectorItem(key: key, isSelected: selected == key)
                        .onTapGesture {
                            hapticTrigger += 1
                            selected = key
                        }
                }
            }
            .padding([.horizontal], 10)
        }
        .scrollIndicators(.hidden)
        .sensoryFeedback(.increase, trigger: hapticTrigger)
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
        .padding([.horizontal], 15)
        .padding([.vertical], 10)
        .background(isSelected ? Color("Text") : .clear)
        .border(isSelected ? Color("Text") : Color("Border"), width: 1)
    }
}
