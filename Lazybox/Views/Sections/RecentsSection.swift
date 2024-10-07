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

import SwiftData
import SwiftUI

struct RecentsSection: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Item.dateModified, order: .reverse) private var items: [Item]

    @State private var new: URL?
    @State private var newLink = false

    @State private var delete: Item?
    @State private var deleteLink = false

    var body: some View {
        Section(
            title: "Recents",
            symbol: "Recent",
            actionSymbol: "NewItem",
            action: {
                paste()
            },
            content: {
                Masonry {
                    ForEach(items) { item in
                        LazyVStack {
                            switch ItemType(rawValue: item.type)! {
                            case .link:
                                if let link = item.link {
                                    LinkBox(link: link)
                                        .contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: 12))
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
                                                delete = item
                                                deleteLink.toggle()
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
            }
        )
        .sheet(
            isPresented: $newLink,
            content: {
                NewLink(url: $new) {
                    newLink = false
                }
            }
        )
        .alert("Delete Link", isPresented: $deleteLink) {
            Button("Delete", role: .destructive) {
                context.delete(delete!)
                deleteLink.toggle()
            }
            Button("Cancel", role: .cancel) {
                deleteLink.toggle()
            }
        }
    }

    func paste() {
        if let pasteString = UIPasteboard.general.url {
            if let url = URL(string: pasteString.absoluteString) {
                self.new = url
                newLink.toggle()
            }
        }
    }
}
