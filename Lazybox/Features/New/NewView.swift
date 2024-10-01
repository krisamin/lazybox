//
//  NewView.swift
//  Lazybox
//
//  Created by noViceMin on 10/1/24.
//

import SwiftUI
import LinkPresentation

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

struct LinkInfo {
    var url: String
    var title: String
    var desc: String
    var host: String
    var image: UIImage?
}

@MainActor
class LinkInfoFetchModel: ObservableObject {
    @Published var info: LinkInfo?

    private enum FetchError: Error {
        case invalidMetadata
        case imageLoadError
    }

    func fetch(from url: URL) {
        Task {
            do {
                info = try await fetchMetadata(from: url)
            } catch {
                print("메타데이터 가져오기 오류: \(error.localizedDescription)")
            }
        }
    }

    func fetchMetadata(from url: URL) async throws -> LinkInfo {
        let metadataProvider = LPMetadataProvider()
        let metadata = try await metadataProvider.startFetchingMetadata(for: url)

        guard let title = metadata.title else {
            throw FetchError.invalidMetadata
        }
        let desc = metadata.value(forKey: "_summary") as? String ?? ""
        let host = url.host ?? ""
        let image = try? await loadImage(from: metadata.imageProvider)

        return LinkInfo(
            url: url.absoluteString,
            title: title,
            desc: desc,
            host: host,
            image: image
        )
    }

    private func loadImage(from provider: NSItemProvider?) async throws -> UIImage? {
        guard let provider = provider else { return nil }

        return try await withCheckedThrowingContinuation { continuation in
            provider.loadObject(ofClass: UIImage.self) { object, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let image = object as? UIImage {
                    continuation.resume(returning: image)
                } else {
                    continuation.resume(throwing: FetchError.imageLoadError)
                }
            }
        }
    }
}

#Preview {
    NewView()
}
