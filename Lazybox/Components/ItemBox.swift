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
//  File    : ItemBox.swift
//

import SwiftUI

struct ItemBox: View {
    let title: String?
    let content: String?
    let cover: UIImage?

    init(title: String? = nil, content: String? = nil, cover: UIImage? = nil) {
        self.title = title
        self.content = content
        self.cover = cover
    }

    var body: some View {
        Box(padding: title != nil) {
            VStack(alignment: .leading, spacing: 12) {
                if let title = title {
                    Text(title)
                        .font(.system(size: 24))
                }
                if let content = content {
                    Text(content)
                        .font(.system(size: 16))
                        .fixedSize(horizontal: false, vertical: true)
                }
                if let cover = cover {
                    Image(uiImage: cover)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                }
            }
        }
    }
}
