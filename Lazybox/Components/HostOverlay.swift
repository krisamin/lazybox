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
//  File    : HostOverlay.swift
//

import SwiftUI

struct HostOverlay: View {
    let host: String
    let icon: Data?

    var body: some View {
        VStack {
            HStack(spacing: 4) {
                if let icon {
                    Image(uiImage: UIImage(data: icon)!)
                        .resizable()
                        .frame(width: 12, height: 12)
                        .cornerRadius(6)
                }
                Text(host)
                    .font(.system(size: 10))
            }
            .padding([.vertical], 4)
            .padding([.leading], icon == nil ? 6 : 4)
            .padding([.trailing], 6)
            .background(Color("Background"))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: 0.5)
                    .stroke(Color("Border"), lineWidth: 1)
            )
        }
        .padding(2)
    }
}
