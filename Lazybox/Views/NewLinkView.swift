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
//  Created : 10/2/24
//  Package : Lazybox
//  File    : NewLinkView.swift
//

import MasonryStack
import SwiftUI

struct NewLinkView: View {
    @Environment(\.modelContext) private var context

    @State private var saving = false
    @StateObject private var model = LinkInfoFetchModel()

    @Binding var url: URL?
    let onDismiss: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if let info = model.info {
                ScrollView {
                    Masonry {
                        if let cover = info.cover {
                            ItemBox(cover: cover)
                        }
                        ItemBox(title: "Title", content: info.title)
                        ItemBox(title: "Description", content: info.desc)
                        ItemBox(title: "Host", content: info.host)
                    }.padding([.horizontal, .top], 6)
                }.scrollIndicators(.hidden)
            } else {
                VStack {
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            HStack(spacing: 6) {
                Chip(title: url?.absoluteString ?? "", filled: false, fill: true)
                Button(
                    action: { saveAndDismiss() },
                    label: {
                        Chip(title: "Save", filled: true)
                    }
                )
                Button(
                    action: { onDismiss() },
                    label: {
                        Chip(title: "Cancel", filled: false)
                    }
                )
            }
            .frame(maxWidth: .infinity)
            .padding(6)
        }
        .background(Color("Background"))
        .foregroundStyle(Color("Text"))
        .disabled(saving)
        .onAppear {
            UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
            if let url {
                model.fetch(from: url)
            }
        }
    }

    private func saveAndDismiss() {
        if let info = model.info {
            saving = true
            let newLink = Link(
                url: info.url,
                title: info.title,
                desc: info.desc,
                host: info.host,
                cover: info.cover?.pngData(),
                icon: info.icon?.pngData()
            )
            let newItem = Item(
                type: .link,
                link: newLink
            )
            context.insert(newItem)

            do {
                try context.save()
                onDismiss()
            } catch {
                print("저장 오류: \(error)")
            }
        }
    }
}
