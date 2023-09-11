/*
 EmojiParser.swift


 Created by Takuto Nakamura on 2023/09/10.

*/

import SwiftUI

struct JsonSkin: Decodable {
    let unified: String
    let native: String
}

struct JsonEmoji: Decodable, Identifiable {
    let id: String
    let name: String
    let skins: [JsonSkin]
    var emoji: String {
        return skins[0].native
    }
}

enum JsonCategoryType: String, Decodable {
    case people
    case nature
    case foods
    case activity
    case places
    case objects
    case symbols
    case flags
}

struct JsonCategory: Decodable {
    let type: JsonCategoryType
    let identifiers: [JsonEmoji.ID]

    enum CodingKeys: String, CodingKey {
        case type = "id"
        case identifiers = "emojis"
    }
}

struct JsonEmojiSet: Decodable {
    let categories: [JsonCategory]
    let emojis: [JsonEmoji.ID: JsonEmoji]
}

final class EmojiParser {
    private func decodeEmojiSet() -> JsonEmojiSet {
        guard let path = Bundle.module.path(forResource: "14", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError("Could not get date from 14.json")
        }
        guard let emojiSet = try? JSONDecoder().decode(JsonEmojiSet.self, from: data) else {
            fatalError("Could not get emoji set from data")
        }
        return emojiSet
    }

    func getEmojiSets() -> [EmojiSet] {
        let emojiSet = decodeEmojiSet()
        return emojiSet.categories.compactMap { jsonCategory -> EmojiSet? in
            guard let emojiCategory = EmojiCategory(jsonCategoryType: jsonCategory.type) else {
                return nil
            }
            let emojis = jsonCategory.identifiers.compactMap { id -> Emoji? in
                guard let jsonEmoji = emojiSet.emojis[id] else { return nil }
                return Emoji(id: jsonEmoji.id, character: jsonEmoji.emoji)
            }
            return EmojiSet(category: emojiCategory, emojis: emojis)
        }
    }
}
