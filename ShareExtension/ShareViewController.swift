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
//  File    : ShareViewController.swift
//

import SwiftData
import SwiftUI
import UniformTypeIdentifiers

@objc(ShareViewController)
class ShareViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let item = extensionContext?.inputItems.first as? NSExtensionItem,
              let attachment = item.attachments?.first
        else {
            close()
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
            ) { item, error in
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
        if let error {
            print("Error loading type \(identifier): \(error.localizedDescription)")
            return
        }

        if let urlString = item as? String,
           let url = URL(string: urlString) {
            handle(url)
        } else if let url = item as? URL {
            handle(url)
        } else if let data = item as? Data,
                  let url = URL(
                      dataRepresentation: data,
                      relativeTo: nil
                  ) {
            handle(url)
        } else {
            print("Unsupported item format: \(String(describing: item))")
        }
    }

    private func handle(_ url: URL) {
        let container = setupModelContainer()
        let contentView = UIHostingController(
            rootView: NewLinkView(
                url: .constant(url),
                onDismiss: { [weak self] in
                    self?.close()
                }
            )
            .modelContainer(container)
        )

        addChild(contentView)
        view.addSubview(contentView.view)

        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.view.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func close() {
        extensionContext?.completeRequest(
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
