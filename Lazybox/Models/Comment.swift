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
//  File    : Comment.swift
//

import Foundation
import SwiftData

@Model
class Comment {
    var dateAdded: Date = Date.now
    var dateModified: Date = Date.now
    var content: String = ""

    var item: Item?

    init(
        dateAdded: Date,
        dateModified: Date,
        content: String,
        item: Item? = nil
    ) {
        self.dateAdded = dateAdded
        self.dateModified = dateModified
        self.content = content
        self.item = item
    }
}
