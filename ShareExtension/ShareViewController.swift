//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by noViceMin on 10/1/24.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers

@objc(ShareViewController)
class ShareViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let item = extensionContext?.inputItems.first as? NSExtensionItem,
              let attachment = item.attachments?.first else {
            self.close()
            return
        }

        let typeIdentifiers = [
            UTType.url.identifier,
            UTType.text.identifier,
            "public.file-url"
        ]
        for identifier in typeIdentifiers {
            attachment.loadItem(
                forTypeIdentifier: identifier,
                options: nil
            ) { (item, error) in
                DispatchQueue.main.async {
                    self.process(
                        item: item,
                        error: error,
                        identifier: identifier
                    )
                }
            }
        }
    }

    private func process(item: Any?, error: Error?, identifier: String) {
        if let error = error {
            print("타입 \(identifier) 로드 오류: \(error.localizedDescription)")
            return
        }

        if let urlString = item as? String {
            handle(urlString)
        } else if let url = item as? URL {
            handle(url.absoluteString)
        } else if let data = item as? Data, let url = URL(
            dataRepresentation: data,
            relativeTo: nil
        ) {
            handle(url.absoluteString)
        } else {
            print("지원되지 않는 항목 형식: \(String(describing: item))")
        }
    }

    private func handle(_ urlString: String) {
        let container = self.setupModelContainer()
        let contentView = UIHostingController(
            rootView: NewLink(
                url: URL(string: urlString)!,
                onDismiss: { [weak self] in
                    self?.close()
                })
            .modelContainer(container)
        )

        self.addChild(contentView)
        self.view.addSubview(contentView.view)

        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            contentView.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            contentView.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }

    private func close() {
        self.extensionContext?.completeRequest(
            returningItems: [],
            completionHandler: nil
        )
    }
    
    private func setupModelContainer() -> ModelContainer {
        let schema = Schema([Link.self])
        let config = ModelConfiguration(
            "Lazybox",
            schema: schema,
            groupContainer: .identifier("group.kr.isamin.lazybox")
        )

        do {
            print(URL.applicationSupportDirectory.path(percentEncoded: false))
            return try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not configure the container")
        }
    }
}
