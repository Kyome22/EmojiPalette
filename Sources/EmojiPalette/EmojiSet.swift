/*
 EmojiSet.swift
 

 Created by Takuto Nakamura on 2023/09/11.
 
*/

public struct EmojiSet: Sendable, Identifiable {
    public var category: EmojiCategory
    public var emojis: [Emoji]
    public var id: String { category.rawValue }
}
