//
//  ContentView.swift
//  Lazybox
//
//  Created by noViceMin on 9/26/24.
//

import SwiftUI
import MasonryStack

struct ContentView: View {
    @State private var tabSelection = 0
    @State private var hapticTrigger = 0

    var body: some View {
        VStack {
            TabView(selection: $tabSelection) {
                HomeScreen()
                    .tag(0)
                SettingsScreen()
                    .tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()
            .onAppear {
                  UIScrollView.appearance().isScrollEnabled = false
            }
            HStack(spacing: 20) {
                Text("box")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundStyle(tabSelection == 0 ? Color("Text") : Color("Dim"))
                    .onTapGesture {
                        hapticTrigger += 1
                        tabSelection = 0
                    }
                Spacer()
                Text("settings")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundStyle(tabSelection == 1 ? Color("Text") : Color("Dim"))
                    .onTapGesture {
                        hapticTrigger += 1
                        tabSelection = 1
                    }
                Text("new")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundStyle(Color("Dim"))
            }
            .padding([.horizontal, .bottom], 10)
            .sensoryFeedback(.increase, trigger: hapticTrigger)
        }
    }
}

#Preview {
    ContentView()
}
