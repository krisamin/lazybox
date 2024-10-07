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
//  Created : 10/1/24
//  Package : Lazybox
//  File    : Link.swift
//

import Foundation
import SwiftData

@Model
class Link {
    var item: Item?
    var url: String = ""
    var title: String = ""
    var desc: String = ""
    var host: String = ""
    @Attribute(.externalStorage)
    var cover: Data?
    @Attribute(.externalStorage)
    var icon: Data?

    init(
        url: String,
        title: String,
        desc: String,
        host: String,
        cover: Data? = nil,
        icon: Data? = nil
    ) {
        self.url = url
        self.title = title
        self.desc = desc
        self.host = host
        self.cover = cover
        self.icon = icon
    }
}
