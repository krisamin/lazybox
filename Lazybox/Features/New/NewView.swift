//
//  NewView.swift
//  Lazybox
//
//  Created by noViceMin on 10/1/24.
//

import SwiftUI

struct NewView: View {
    @Environment(\.modelContext) private var context
    @StateObject private var model = LinkInfoFetchModel()
    @State private var url: String = ""

    var body: some View {
        VStack {
            List {
                TextField("URL", text: $url)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .onSubmit {
                        model.fetch(from: URL(string: url)!)
                    }
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

                        model.info = nil
                        url = ""
                    }
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    NewView()
}
