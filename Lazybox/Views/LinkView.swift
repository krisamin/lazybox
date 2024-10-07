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

struct LinkView: View {
    @Environment(\.modelContext) private var context
    @Query private var comments: [Comment]
    let link: Link

    @State private var comment = ""
    @FocusState private var isCommentFocused: Bool

    @State private var deleteComment: Comment?
    @State private var deleteCommentConfirm = false

    init(link: Link) {
        self.link = link
        let itemId = link.item?.persistentModelID
        _comments = Query(filter: #Predicate {
            $0.item?.persistentModelID == itemId
        }, sort: [
            SortDescriptor(\Comment.dateModified, order: .reverse)
        ])
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 6) {
                ScrollView {
                    VStack(spacing: 6) {
                        if let cover = link.cover {
                            ItemBox(cover: UIImage(data: cover)!)
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
        do {
            context.insert(newComment)
            try context.save()
            comment = ""
            isCommentFocused = false
        } catch {
            print("댓글 저장 중 오류 발생: \(error)")
        }
    }
}
