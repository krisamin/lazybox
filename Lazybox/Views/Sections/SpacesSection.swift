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
//  File    : SpacesSection.swift
//

import SwiftData
import SwiftUI

struct SpacesSection: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Space.dateModified, order: .reverse) private var spaces: [Space]

    @State private var new: String = ""
    @State private var newSpace = false

    @State private var delete: Space?
    @State private var deleteSpace = false

    var body: some View {
        Section(
            title: "Spaces",
            symbol: "Space",
            actionSymbol: "NewSpace",
            action: {
                new = ""
                newSpace.toggle()
            },
            content: {
                Masonry {
                    TextBox(title: "Drafts")
                    ForEach(spaces) { space in
                        LazyVStack {
                            TextBox(title: space.name)
                                .contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: 12))
                                .contextMenu {
                                    Button(role: .destructive) {
                                        delete = space
                                        deleteSpace.toggle()
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                    }
                }
            }
        )
        .alert("New Space", isPresented: $newSpace) {
            TextField(new, text: $new)
            Button("Create") {
                let space = Space(name: new)
                context.insert(space)
                newSpace.toggle()
            }
            Button("Cancel", role: .cancel) {
                newSpace.toggle()
            }
        }
        .alert("Delete Space", isPresented: $deleteSpace) {
            Button("Delete", role: .destructive) {
                context.delete(delete!)
                deleteSpace.toggle()
            }
            Button("Cancel", role: .cancel) {
                deleteSpace.toggle()
            }
        }
    }
}
