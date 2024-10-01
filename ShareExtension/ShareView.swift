//
//  ShareView.swift
//  ShareExtension
//
//  Created by noViceMin on 10/1/24.
//

import SwiftUI

struct ShareView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var model = LinkInfoFetchModel()
    
    let url: URL
    let onDismiss: () -> Void
    
    var body: some View {
        List {
            if let info = model.info {
                LabeledContent("url") {
                    Text(info.url)
                }
                LabeledContent("title") {
                    Text(info.title)
                }
                LabeledContent("desc") {
                    Text(info.desc)
                }
                LabeledContent("host") {
                    Text(info.host)
                }
                if let image = info.image {
                    LabeledContent("image") {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    }
                }
                Button("Save") {
                    let newLink = Link(
                        url: info.url,
                        titlie: info.title,
                        desc: info.desc,
                        host: info.host,
                        image: info.image?.pngData()
                    )
                    context.insert(newLink)
//                    onDismiss()
                }
            }
        }
        .listStyle(.plain)
        .onAppear() {
            model.fetch(from: url)
        }
    }
}
