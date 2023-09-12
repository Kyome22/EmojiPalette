/*
 EmojiPaletteView.swift
 

 Created by Takuto Nakamura on 2023/09/11.
 
*/

import SwiftUI

public struct EmojiPaletteView: View {
    @Binding var selectedEmoji: String
    @State var emojiSets: [EmojiSet]
    @State var selection: EmojiCategory = .smileysAndPeople
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 8), count: 6)

    public init(selectedEmoji: Binding<String>) {
        _selectedEmoji = selectedEmoji
        emojiSets = EmojiParser.shared.emojiSets
    }

    public var body: some View {
        VStack(spacing: 0) {
            if let emojiSet = emojiSets.first(where: { $0.category == selection }) {
                List {
                    Section {
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(emojiSet.emojis) { emoji in
                                Button {
                                    selectedEmoji = emoji.character
                                } label: {
                                    Text(emoji.character)
                                        .font(.system(size: 26))
                                }
                                .buttonStyle(.borderless)
                                .frame(width: 32, height: 32)
                            }
                        }
                    } header: {
                        Text(emojiSet.category.label, bundle: .module)
                    }
                    .textCase(.none)
                }
                .listStyle(.plain)
                .id(selection)
            }
            Divider()
            HStack(spacing: 8) {
                ForEach(EmojiCategory.allCases) { emojiCategory in
                    Image(systemName: emojiCategory.imageName)
                        .frame(width: 24, height: 24)
                        .foregroundColor(selection == emojiCategory ? Color.accentColor : .secondary)
                        .onTapGesture {
                            selection = emojiCategory
                        }
                }
            }
            .padding(8)
        }
        .frame(width: 264, height: 320) // width = (2 * 16) + (6 * 32) + (5 * 8) = 264
    }
}

struct EmojiPaletteView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiPaletteView(selectedEmoji: .constant(""))
    }
}
