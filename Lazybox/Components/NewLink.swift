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
//  File    : NewLink.swift
//

import MasonryStack
import SwiftUI

struct NewLink: View {
    @Environment(\.modelContext) private var context

    @State private var saving = false
    @StateObject private var model = LinkInfoFetchModel()

    @Binding var url: URL?
    let onDismiss: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if let info = model.info {
                ScrollView {
                    MasonryVStack(columns: 2, spacing: 6) {
                        NewLinkBox(title: "Title", content: info.title)
                        NewLinkBox(title: "Description", content: info.desc)
                        if let cover = info.cover {
                            NewLinkBox(title: "Preview", cover: cover)
                        }
                        NewLinkBox(title: "Host", content: info.host)
                    }.padding([.horizontal, .top], 6)
                }.scrollIndicators(.hidden)
            } else {
                VStack {
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            HStack {
                Chip(title: url?.absoluteString ?? "", filled: false, fill: true)
                Chip(title: "Save", filled: true)
                    .onTapGesture { saveAndDismiss() }
                Chip(title: "Cancel", filled: false)
                    .onTapGesture { onDismiss() }
            }
            .frame(maxWidth: .infinity)
            .padding([.horizontal, .bottom], 6)
        }
        .background(Color("Background"))
        .foregroundStyle(Color("Text"))
        .disabled(saving)
        .onAppear {
            UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
            if let url = url {
                model.fetch(from: url)
            }
        }
    }

    private func saveAndDismiss() {
        if let info = model.info {
            saving = true
            let newLink = Link(
                url: info.url,
                titlie: info.title,
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

struct NewLinkBox: View {
    let title: String
    let content: String?
    let cover: UIImage?

    init(title: String, content: String? = nil, cover: UIImage? = nil) {
        self.title = title
        self.content = content
        self.cover = cover
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 28, weight: .medium))
            if let content = content {
                Text(content)
                    .font(.system(size: 16))
                    .fixedSize(horizontal: false, vertical: true)
            }
            if let cover = cover {
                Image(uiImage: cover)
                    .resizable()
                    .scaledToFit()
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding(12)
        .background(Color("Card"))
        .border(Color("Border"), width: 1)
    }
}
