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
        emojiSets = EmojiParser.shared.emojiSet
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
                                        .font(.title)
                                }
                                .buttonStyle(.borderless)
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
            HStack {
                ForEach(EmojiCategory.allCases) { emojiCategory in
                    Image(systemName: emojiCategory.imageName)
                        .foregroundColor(selection == emojiCategory ? Color.accentColor : .secondary)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            selection = emojiCategory
                        }
                }
            }
            .padding(8)
        }
        .frame(width: 240, height: 320)
    }
}

struct EmojiPaletteView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiPaletteView(selectedEmoji: .constant(""))
    }
}
