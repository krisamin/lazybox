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
        VStack(spacing: 12) {
            if let cover = link.cover {
                Image(uiImage: UIImage(data: cover)!)
                    .resizable()
                    .scaledToFit()
                    .overlay(alignment: .bottomTrailing) {
                        VStack {
                            HStack(spacing: 4) {
                                if let icon = link.icon {
                                    Image(uiImage: UIImage(data: icon)!)
                                        .resizable()
                                        .frame(width: 12, height: 12)
                                        .cornerRadius(6)
                                }
                                Text(link.host)
                                    .font(.system(size: 10))
                            }
                            .padding(4)
                            .background(Color("Background"))
                            .border(Color("Border"), width: 1)
                        }
                        .padding(2)
                    }
            }
            Text(link.titlie)
                .font(.system(size: 16))
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding(12)
        .background(Color("Card"))
        .border(Color("Border"), width: 1)
    }
}
