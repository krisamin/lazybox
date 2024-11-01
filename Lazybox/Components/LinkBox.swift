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
//  File    : LinkBox.swift
//

import SwiftUI

struct LinkBox: View {
    let link: Link

    var body: some View {
        NavigationLink {
            LinkView(link: link)
        } label: {
            Box(padding: false, square: true) {
                Color.clear
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay {
                        if let cover = link.cover {
                            Image(uiImage: UIImage(data: cover)!)
                                .resizable()
                                .scaledToFill()
                        }
                    }
                    .overlay(alignment: .bottomTrailing) {
                        HostOverlay(host: link.host, icon: link.icon)
                    }
                    .cornerRadius(12)
                    .clipped()
                VStack {
                    Text(link.title)
                        .font(.system(size: 16))
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                .padding(12)
            }
        }
        .buttonStyle(.plain)
    }
}
