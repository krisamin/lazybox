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
//  Created : 10/7/24
//  Package : Lazybox
//  File    : LinkView.swift
//

import SwiftData
import SwiftUI
import SwiftUIIntrospect

struct LinkView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Query private var comments: [Comment]
    let link: Link

    @State private var comment = ""
    @FocusState private var isCommentFocused: Bool

    @State private var deleteConfirm = false

    @State private var deleteComment: Comment?
    @State private var deleteCommentConfirm = false

    init(link: Link) {
        self.link = link
        let itemId = link.item?.persistentModelID
        _comments = Query(
            filter: #Predicate {
                $0.item?.persistentModelID == itemId
            },
            sort: [
                SortDescriptor(\Comment.dateModified, order: .reverse)
            ]
        )
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 6) {
                ScrollView {
                    VStack(spacing: 6) {
                        if let cover = link.cover {
                            Image(uiImage: UIImage(data: cover)!)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(12)
                                .overlay(alignment: .bottomTrailing) {
                                    HostOverlay(host: link.host, icon: link.icon)
                                }
                        }
                        HStack(spacing: 6) {
                            ActionButton(
                                title: "Open",
                                symbol: "Open20",
                                fill: true,
                                action: {
                                    UIApplication.shared.open(URL(string: link.url)!)
                                }
                            )
                            ActionButton(
                                title: "Share",
                                symbol: "Share20",
                                fill: true,
                                action: {
                                    let activityViewController = UIActivityViewController(
                                        activityItems: [URL(string: link.url)!],
                                        applicationActivities: nil
                                    )

                                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                       let window = windowScene.windows.first // swiftlint:disable:next opening_brace
                                    {
                                        window.rootViewController?.present(activityViewController, animated: true)
                                    }
                                }
                            )
                            ActionButton(
                                title: "Delete",
                                symbol: "Delete20",
                                fill: true,
                                action: {
                                    deleteConfirm.toggle()
                                }
                            )
                        }
                        ItemBox(title: link.title, content: link.desc)
                        VStack(spacing: 6) {
                            ForEach(comments) { comment in
                                Box {
                                    Text(comment.content)
                                        .font(.system(size: 16))
                                }
                                .contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: 12))
                                .contextMenu {
                                    Button {
                                        UIPasteboard.general.string = comment.content
                                    } label: {
                                        Label("Copy", systemImage: "doc.on.doc")
                                    }
                                    Divider()
                                    Button(role: .destructive) {
                                        deleteComment = comment
                                        deleteCommentConfirm.toggle()
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                            }
                        }
                    }
                    .padding(6)
                }
                .scrollIndicators(.hidden)
                HStack(spacing: 6) {
                    TextField("Enter comment here", text: $comment)
                        .textFieldStyle(CustomTextFieldStyle())
                        .focused($isCommentFocused)
                        .onSubmit {
                            sendComment()
                        }
                    Chip(title: "Send", filled: true)
                        .onTapGesture {
                            sendComment()
                        }
                }
                .padding(6)
            }
            .navigationBarBackButtonHidden()
        }
        .introspect(.navigationStack, on: .iOS(.v18)) {
            for controller in $0.viewControllers {
                controller.view.backgroundColor = .clear
            }
        }
        .background(Color("Background"))
        .alert("Delete Link", isPresented: $deleteConfirm) {
            Button("Delete", role: .destructive) {
                if let item = link.item {
                    context.delete(item)
                }
                dismiss()
            }
            Button("Cancel", role: .cancel) {
                deleteConfirm.toggle()
            }
        }
        .alert("Delete Comment", isPresented: $deleteCommentConfirm) {
            Button("Delete", role: .destructive) {
                context.delete(deleteComment!)
                deleteCommentConfirm.toggle()
            }
            Button("Cancel", role: .cancel) {
                deleteCommentConfirm.toggle()
            }
        }
    }

    private func sendComment() {
        guard !comment.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        guard let item = link.item else { return }

        let newComment = Comment(content: comment, item: item)
        context.insert(newComment)
        comment = ""
        isCommentFocused = false
    }
}
