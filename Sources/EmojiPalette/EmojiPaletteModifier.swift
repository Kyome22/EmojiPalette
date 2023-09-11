/*
 EmojiPaletteModifier.swift
 

 Created by Takuto Nakamura on 2023/09/11.
 
*/

import SwiftUI

public struct EmojiPaletteModifier: ViewModifier {
    @Binding var selectedEmoji: String
    @Binding var isPresented: Bool
    let attachmentAnchor: PopoverAttachmentAnchor
    let arrowEdge: Edge

    public init(
        selectedEmoji: Binding<String>,
        isPresented: Binding<Bool>,
        attachmentAnchor: PopoverAttachmentAnchor = .rect(.bounds),
        arrowEdge: Edge = .top
    ) {
        _selectedEmoji = selectedEmoji
        _isPresented = isPresented
        self.attachmentAnchor = attachmentAnchor
        self.arrowEdge = arrowEdge
    }

    public func body(content: Content) -> some View {
        content.popover(
            isPresented: $isPresented,
            attachmentAnchor: attachmentAnchor,
            arrowEdge: arrowEdge
        ) {
            if #available(iOS 16.4, *) {
                EmojiPaletteView(selectedEmoji: $selectedEmoji)
                    .presentationCompactAdaptation(.popover)
            } else {
                EmojiPaletteView(selectedEmoji: $selectedEmoji)
            }
        }
    }
}

extension View {
    public func emojiPalette(
        selectedEmoji: Binding<String>,
        isPresented: Binding<Bool>,
        attachmentAnchor: PopoverAttachmentAnchor = .rect(.bounds),
        arrowEdge: Edge = .top
    ) -> some View {
        return modifier(EmojiPaletteModifier(
            selectedEmoji: selectedEmoji,
            isPresented: isPresented,
            attachmentAnchor: attachmentAnchor,
            arrowEdge: arrowEdge
        ))
    }
}
