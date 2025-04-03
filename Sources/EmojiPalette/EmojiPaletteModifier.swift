/*
 EmojiPaletteModifier.swift
 

 Created by Takuto Nakamura on 2023/09/11.
 
*/

import SwiftUI

public struct EmojiPaletteModifier: ViewModifier {
    @Binding var selectedEmoji: String
    @Binding var isPresented: Bool
    var attachmentAnchor: PopoverAttachmentAnchor
    var arrowEdge: Edge?

    public init(
        selectedEmoji: Binding<String>,
        isPresented: Binding<Bool>,
        attachmentAnchor: PopoverAttachmentAnchor = .rect(.bounds),
        arrowEdge: Edge? = nil
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
            EmojiPaletteView(selectedEmoji: $selectedEmoji)
                .clipShape(Rectangle())
                .presentationCompactAdaptation(.popover)
        }
    }
}

extension View {
    public func emojiPalette(
        selectedEmoji: Binding<String>,
        isPresented: Binding<Bool>,
        attachmentAnchor: PopoverAttachmentAnchor = .rect(.bounds),
        arrowEdge: Edge? = nil
    ) -> some View {
        modifier(EmojiPaletteModifier(
            selectedEmoji: selectedEmoji,
            isPresented: isPresented,
            attachmentAnchor: attachmentAnchor,
            arrowEdge: arrowEdge
        ))
    }
}
