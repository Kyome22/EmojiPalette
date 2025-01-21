# EmojiPalette

Emoji Picker for iOS using SwiftUI.

<img src="./sample.png" width="300px" />

## Requirements

- Development with Xcode 16.2+
- Written in Swift 6.0
- Compatible with iOS 16.4+

## Usage

```swift
import SwiftUI
import EmojiPalette

struct ContentView: View {
    @State var showPopover: Bool = false
    @State var emoji: String = ""

    var body: some View {
        VStack {
            Button {
                showPopover = true
            } label: {
                Text(emoji)
                    .font(.largeTitle)
            }
            .emojiPalette(selectedEmoji: $emoji,
                          isPresented: $showPopover)
        }
        .padding()
        .onAppear {
            emoji = EmojiParser.shared.randomEmoji()?.character ?? ""
        }
    }
}
```

## Localization

- English (en)
- Japanese (ja)
