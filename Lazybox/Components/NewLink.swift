//
//  NewLink.swift
//  Lazybox
//
//  Created by noViceMin on 10/2/24.
//

import SwiftUI
import MasonryStack

struct NewLink: View {
    @Environment(\.modelContext) private var context

    @State private var saving = false
    @StateObject private var model = LinkInfoFetchModel()

    let url: URL
    let onDismiss: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if let info = model.info {
                ScrollView {
                    MasonryVStack(
                        columns: 2,
                        spacing: 6
                    ) {
                        NewLinkBox(title: "Title", content: info.title)
                        NewLinkBox(title: "Description", content: info.desc)
                        if let image = info.image {
                            NewLinkBox(title: "Preview", image: image)
                        }
                        NewLinkBox(title: "Host", content: info.host)
                    }
                    .padding([.horizontal, .top], 6)
                }
                .scrollIndicators(.hidden)
            } else {
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            HStack {
                Chip(title: url.absoluteString, filled: false, fill: true)
                Chip(title: "Save", filled: true)
                    .onTapGesture {
                        saveAndDismiss()
                    }
                Chip(title: "Cancel", filled: false)
                    .onTapGesture {
                        onDismiss()
                    }
            }
            .frame(maxWidth: .infinity)
            .padding([.horizontal, .bottom], 6)
        }
        .background(Color("Background"))
        .onAppear {
            model.fetch(from: url)
        }
        .disabled(saving)
    }

    private func saveAndDismiss() {
        if let info = model.info {
            saving = true
            let newLink = Link(
                url: info.url,
                titlie: info.title,
                desc: info.desc,
                host: info.host,
                image: info.image?.pngData()
            )
            context.insert(newLink)

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
    let image: UIImage?

    init(title: String, content: String? = nil, image: UIImage? = nil) {
        self.title = title
        self.content = content
        self.image = image
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 28, weight: .medium))
                .foregroundStyle(Color("Text"))
            if let content = content {
                Text(content)
                    .font(.system(size: 16))
                    .foregroundStyle(Color("Text"))
                    .fixedSize(horizontal: false, vertical: true)
            }
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(6)
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding(12)
        .background(Color("Card"))
        .cornerRadius(18)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .inset(by: 0.5)
                .stroke(Color("Border"), lineWidth: 1)
        )
    }
}
