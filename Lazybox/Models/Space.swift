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
//  File    : Space.swift
//

import Foundation
import SwiftData

@Model
class Space {
    var dateAdded: Date = Date.now
    var dateModified: Date = Date.now
    var name: String = ""

    var items: [Item]?

    init(
        dateAdded: Date = Date.now,
        dateModified: Date = Date.now,
        name: String
    ) {
        self.dateAdded = dateAdded
        self.dateModified = dateModified
        self.name = name
    }
}
