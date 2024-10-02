//
//  LinkBox.swift
//  Lazybox
//
//  Created by noViceMin on 10/1/24.
//

import SwiftUI

struct LinkBox: View {
    let link: Link

    var body: some View {
        VStack(spacing: 12) {
            if let image = link.image {
                Image(uiImage: UIImage(data: image)!)
                    .resizable()
                    .scaledToFit()
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
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding(12)
        .background(Color("Card"))
        .cornerRadius(18)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .inset(by: 0.5)
                .stroke(Color("Border"), lineWidth: 1)
        )
    }
}
