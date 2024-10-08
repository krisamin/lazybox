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

    @Namespace private var namespace

    var body: some View {
        NavigationLink {
            LinkView(link: link)
                .navigationTransition(.zoom(sourceID: link.id, in: namespace))
        } label: {
            Box(padding: false) {
                if let cover = link.cover {
                    Image(uiImage: UIImage(data: cover)!)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .overlay(alignment: .bottomTrailing) {
                            HostOverlay(host: link.host, icon: link.icon)
                        }
                }
                VStack {
                    Text(link.title)
                        .font(.system(size: 16))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(12)
            }
            .matchedTransitionSource(id: link.id, in: namespace)
        }
        .buttonStyle(.plain)
    }
}
