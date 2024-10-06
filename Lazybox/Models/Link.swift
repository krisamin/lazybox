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
    var titlie: String = ""
    var desc: String = ""
    var host: String = ""
    @Attribute(.externalStorage)
    var cover: Data?
    @Attribute(.externalStorage)
    var icon: Data?

    init(
        url: String,
        titlie: String,
        desc: String,
        host: String,
        cover: Data? = nil,
        icon: Data? = nil
    ) {
        self.url = url
        self.titlie = titlie
        self.desc = desc
        self.host = host
        self.cover = cover
        self.icon = icon
    }
}
