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
//  Created : 10/6/24
//  Package : Lazybox
//  File    : LinkInfo.swift
//

import LinkPresentation
import SwiftData
import SwiftUI

struct LinkInfo {
    var url: String
    var title: String
    var desc: String
    var host: String
    var cover: UIImage?
    var icon: UIImage?
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
        let cover = try? await loadImage(from: metadata.imageProvider)
        let icon = try? await loadImage(from: metadata.iconProvider, resize: true)

        return LinkInfo(
            url: url.absoluteString,
            title: title,
            desc: desc,
            host: host,
            cover: cover,
            icon: icon
        )
    }

    private func loadImage(from provider: NSItemProvider?, resize: Bool = false) async throws -> UIImage? {
        guard let provider else { return nil }

        return try await withCheckedThrowingContinuation { continuation in
            provider.loadObject(ofClass: UIImage.self) { object, error in
                if let error {
                    continuation.resume(throwing: error)
                } else if let image = object as? UIImage {
                    if resize {
                        let size = CGSize(width: 32, height: 32)
                        let renderer = UIGraphicsImageRenderer(size: size)
                        let resizedImage = renderer.image { _ in
                            image.draw(in: CGRect(origin: .zero, size: size))
                        }
                        print(image.size)
                        print(resizedImage.size)
                        continuation.resume(returning: resizedImage)

                    } else {
                        continuation.resume(returning: image)
                    }
                } else {
                    continuation.resume(throwing: FetchError.imageLoadError)
                }
            }
        }
    }
}
