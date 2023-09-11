# EmojiPalette

Emoji Picker for iOS using SwiftUI.

<img src="./sample.png" width="300px" />

## Usage

```swift
import SwiftUI
import EmojiPalette

struct ContentView: View {
    @State var showPopover: Bool = false
    @State var emoji: String = "💪"

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
    }
}
```
