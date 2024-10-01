//
//  Link.swift
//  Lazybox
//
//  Created by noViceMin on 10/1/24.
//

import SwiftUI
import SwiftData

@Model
class Link {
    var url: String = ""
    var titlie: String = ""
    var desc: String = ""
    var host: String = ""
    @Attribute(.externalStorage)
    var image: Data?
    var dateAdded: Date = Date.now

    init(
        url: String,
        titlie: String,
        desc: String,
        host: String,
        image: Data? = nil,
        dateAdded: Date = Date.now
    ) {
        self.url = url
        self.titlie = titlie
        self.desc = desc
        self.host = host
        self.image = image
        self.dateAdded = dateAdded
    }
}
