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
//  File    : ContentView.swift
//

import MasonryStack
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Query(sort: \Link.dateAdded, order: .reverse) private var links: [Link]

    @State private var url: URL?
    @State private var newLink = false

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                MasonryVStack(
                    columns: horizontalSizeClass == .compact
                        ? 2
                        : Int(round(Float(proxy.size.width) / 300.0)),
                    spacing: 6
                ) {
                    ActionButton(title: "Paste", image: "Paste")
                        .onTapGesture(perform: paste)
                    ForEach(links) { link in
                        LazyVStack {
                            LinkBox(link: link)
                                .onTapGesture {
                                    UIApplication.shared.open(URL(string: link.url)!)
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
            .sheet(
                isPresented: $newLink,
                content: {
                    NewLink(url: $url) {
                        newLink = false
                    }
                }
            )
        }
    }

    func paste() {
        if let pasteString = UIPasteboard.general.url {
            if let url = URL(string: pasteString.absoluteString) {
                self.url = url
                newLink = true
            }
        }
    }
}

#Preview {
    let preview = Preview(Link.self)

    ContentView()
        .modelContainer(preview.container)
}
