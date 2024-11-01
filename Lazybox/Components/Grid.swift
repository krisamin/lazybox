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
//  Created : 11/1/24
//  Package : Lazybox
//  File    : Grid.swift
//

import SwiftUI

struct Grid<Content: View, T: Identifiable>: View where T: Hashable {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var columns: Int = 2

    var content: (T) -> Content
    var list: [T]

    init(list: [T], content: @escaping (T) -> Content) {
        self.content = content
        self.list = list
    }

    func setup() -> [[T]] {
        var gridArray: [[T]] = Array(repeating: [], count: columns)
        var currentIndex = 0

        for object in list {
            gridArray[currentIndex].append(object)
            if currentIndex == (columns - 1) {
                currentIndex = 0
            } else {
                currentIndex += 1
            }
        }

        return gridArray
    }

    var body: some View {
        HStack(alignment: .top) {
            ForEach(setup(), id: \.self) { columnData in
                LazyVStack(spacing: 6) {
                    ForEach(columnData, id: \.self) { item in
                        content(item)
                    }
                }
            }
        }
        .padding(6)
        .background(
            GeometryReader { proxy -> Color in
                DispatchQueue.main.async {
                    columns = horizontalSizeClass == .compact ? 2 : Int(round(Float(proxy.size.width) / 300.0))
                }
                return Color.clear
            }
        )
    }
}
