//
//  HomeScreen.swift
//  Lazybox
//
//  Created by noViceMin on 9/26/24.
//

import SwiftUI
import SwiftData
import MasonryStack

struct HomeView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Query(sort: \Link.dateAdded, order: .reverse) private var links: [Link]

    @State private var selected = "Recents"

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 6) {
                ScrollView {
                    MasonryVStack(
                        columns: horizontalSizeClass == .compact ? 2 : Int(round(Float(proxy.size.width) / 300.0)),
                        spacing: 6
                    ) {
                        ForEach(links) { link in
                            LinkBox(link: link)
                                .contextMenu {
                                    Button("Delete", role: .destructive) {
                                        context.delete(link)
                                    }
                                }
                        }
                    }
                    .padding([.horizontal, .top], 6)
                }
                .scrollIndicators(.hidden)
                Selector(keys: ["Recents", "Drafts"], selected: $selected)
            }
        }
    }
}

struct LinkBox: View {
    let link: Link

    var body: some View {
        VStack(spacing: 12) {
            if let image = link.image {
                Image(uiImage: UIImage(data: image)!)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(6)
                    .overlay(alignment: .bottomTrailing) {
                        VStack {
                            HStack {
                                Text(link.host)
                                    .font(.system(size: 10))
                                    .foregroundColor(Color("Text"))
                            }
                            .padding(.horizontal, 6)
                            .padding(.vertical, 4)
                            .background(Color("Card"))
                            .cornerRadius(4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .inset(by: 0.5)
                                    .stroke(Color("Border"), lineWidth: 1)
                            )
                        }
                        .padding(2)
                    }
            }
            Text(link.titlie)
                .font(.system(size: 16))
                .foregroundStyle(Color("Text"))
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(Color("Card"))
        .cornerRadius(18)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .inset(by: 0.5)
                .stroke(Color("Border"), lineWidth: 1)
        )
    }
}
