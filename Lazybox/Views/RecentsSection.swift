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
//  Created : 10/6/24
//  Package : Lazybox
//  File    : RecentsSection.swift
//

import MasonryStack
import SwiftData
import SwiftUI

struct RecentsSection: View {
    @Environment(\.modelContext) private var context
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Query(sort: \Item.dateAdded, order: .reverse) private var items: [Item]

    @State private var url: URL?
    @State private var newLink = false
    @State private var columnCount: Int = 2

    var body: some View {
        Section(title: "Recents", symbol: "Recent", actionSymbol: "NewItem", action: {
            paste()
        }) {
            MasonryVStack(
                columns: columnCount,
                spacing: 6
            ) {
                ForEach(items) { item in
                    LazyVStack {
                        switch ItemType(rawValue: item.type)! {
                        case .link:
                            if let link = item.link {
                                LinkBox(link: link)
                                    .onTapGesture {
                                        UIApplication.shared.open(URL(string: link.url)!)
                                    }
                                    .contentShape(.contextMenuPreview, Rectangle())
                                    .contextMenu {
                                        Button {
                                            UIPasteboard.general.url = URL(string: link.url)!
                                        } label: {
                                            Label("Copy", systemImage: "doc.on.doc")
                                        }
                                        ShareLink(
                                            item: URL(string: link.url)!
                                        ) {
                                            Label("Share", systemImage: "square.and.arrow.up")
                                        }
                                        Divider()
                                        Button(role: .destructive) {
                                            context.delete(item)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                            }
                        case .note:
                            if let note = item.note {
                                VStack {
                                    Text(note.title)
                                    Text("WIP")
                                }
                            }
                        }
                    }
                }
            }
            .padding(6)
        }
        .background(
            GeometryReader { (proxy) -> Color in
                DispatchQueue.main.async {
                    columnCount = horizontalSizeClass == .compact ? 2 : Int(round(Float(proxy.size.width) / 300.0))
                }
                return Color.clear
            }
        )
        .sheet(
            isPresented: $newLink,
            content: {
                NewLink(url: $url) {
                    newLink = false
                }
            }
        )
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
