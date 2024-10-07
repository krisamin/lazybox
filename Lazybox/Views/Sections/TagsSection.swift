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
//  Created : 10/7/24
//  Package : Lazybox
//  File    : TagsSection.swift
//

import SwiftData
import SwiftUI

struct TagsSection: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Tag.dateModified, order: .reverse) private var tags: [Tag]

    @State private var new: String = ""
    @State private var newTag = false

    @State private var delete: Tag?
    @State private var deleteTag = false

    var body: some View {
        Section(
            title: "Tags",
            symbol: "Tag",
            actionSymbol: "NewTag",
            action: {
                new = ""
                newTag.toggle()
            },
            content: {
                Masonry {
                    ForEach(tags) { tag in
                        LazyVStack {
                            TextBox(title: tag.name)
                                .contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: 12))
                                .contextMenu {
                                    Button(role: .destructive) {
                                        delete = tag
                                        deleteTag.toggle()
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                    }
                }
            }
        )
        .alert("New Tag", isPresented: $newTag) {
            TextField(new, text: $new)
            Button("Create") {
                let tag = Tag(name: new)
                context.insert(tag)
                newTag.toggle()
            }
            Button("Cancel", role: .cancel) {
                newTag.toggle()
            }
        }
        .alert("Delete Tag", isPresented: $deleteTag) {
            Button("Delete", role: .destructive) {
                context.delete(delete!)
                deleteTag.toggle()
            }
            Button("Cancel", role: .cancel) {
                deleteTag.toggle()
            }
        }
    }
}
