//
//  ContentView.swift
//  Example
//
//  Created by Takuto Nakamura on 2025/01/22.
//

import SwiftUI
import EmojiPalette

struct ContentView: View {
    @State var showPopover = false
    @State var emoji = ""

    var body: some View {
        VStack {
            Button {
                showPopover = true
            } label: {
                Text(emoji)
                    .font(.largeTitle)
            }
            .buttonStyle(.bordered)
            .emojiPalette(
                selectedEmoji: $emoji,
                isPresented: $showPopover
            )
        }
        .padding()
        .onAppear {
            emoji = EmojiParser.shared.randomEmoji()?.character ?? ""
        }
    }
}

#Preview {
    ContentView()
}
