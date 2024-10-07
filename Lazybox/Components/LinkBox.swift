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
                                .padding([.vertical, .leading], 4)
                                .padding([.trailing], 6)
                                .background(Color("Background"))
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .inset(by: 0.5)
                                        .stroke(Color("Border"), lineWidth: 1)
                                )
                            }
                            .padding(2)
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
    }
}
