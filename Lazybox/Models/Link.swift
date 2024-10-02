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
//  File    : Link.swift
//

import LinkPresentation
import SwiftData
import SwiftUI

@Model
class Link {
    var url: String = ""
    var titlie: String = ""
    var desc: String = ""
    var host: String = ""
    @Attribute(.externalStorage) var image: Data?
    var dateAdded: Date = Date.now

    init(url: String, titlie: String, desc: String, host: String, image: Data? = nil, dateAdded: Date = Date.now) {
        self.url = url
        self.titlie = titlie
        self.desc = desc
        self.host = host
        self.image = image
        self.dateAdded = dateAdded
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

        guard let title = metadata.title else { throw FetchError.invalidMetadata }
        let desc = metadata.value(forKey: "_summary") as? String ?? ""
        let host = (url.host ?? "").replacingOccurrences(of: "www.", with: "")
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
