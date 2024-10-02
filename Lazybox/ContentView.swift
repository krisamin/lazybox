//
//  ContentView.swift
//  Lazybox
//
//  Created by noViceMin on 9/26/24.
//

import MasonryStack
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Query(sort: \Link.dateAdded, order: .reverse) private var links: [Link]

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                MasonryVStack(
                    columns: horizontalSizeClass == .compact
                        ? 2
                        : Int(
                            round(
                                Float(
                                    proxy.size.width
                                ) / 300.0
                            )
                        ),
                    spacing: 6
                ) {
                    ForEach(links) { link in
                        LazyVStack {
                            LinkBox(link: link)
                                .onTapGesture {
                                    UIApplication.shared.open(
                                        URL(string: link.url)!)
                                }
                                .contextMenu {
                                    Button("Delete", role: .destructive) {
                                        context.delete(link)
                                    }
                                }
                        }
                    }
                }
                .padding(6)
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    let preview = Preview(Link.self)

    ContentView()
        .modelContainer(preview.container)
}
