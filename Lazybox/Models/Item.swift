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
//  File    : Item.swift
//

import Foundation
import SwiftData

@Model
class Item {
    var dateAdded: Date = Date.now
    var dateModified: Date = Date.now
    var type: ItemType.RawValue = ItemType.link.rawValue

    @Relationship(deleteRule: .cascade, inverse: \Link.item)
    var link: Link?
    @Relationship(deleteRule: .cascade, inverse: \Note.item)
    var note: Note?

    @Relationship(deleteRule: .nullify, inverse: \Space.items)
    var space: Space?
    @Relationship(deleteRule: .nullify, inverse: \Tag.items)
    var tags: [Tag]?
    @Relationship(deleteRule: .cascade, inverse: \Comment.item)
    var comments: [Comment]?

    init(
        dateAdded: Date = Date.now,
        dateModified: Date = Date.now,
        type: ItemType,

        link: Link? = nil,
        note: Note? = nil,

        space: Space? = nil,
        tags: [Tag] = []
    ) {
        self.dateAdded = dateAdded
        self.dateModified = dateModified
        self.type = type.rawValue

        self.link = link
        self.note = note

        self.space = space
        self.tags = tags
    }
}

enum ItemType: Int, Codable, Identifiable, CaseIterable {
    case link, note
    var id: Self {
        self
    }
}
