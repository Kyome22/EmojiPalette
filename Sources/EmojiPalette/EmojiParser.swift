/*
 EmojiParser.swift


 Created by Takuto Nakamura on 2023/09/10.

*/

import Foundation
import os

public final class EmojiParser: Sendable {
    public static let shared = EmojiParser()

    private let protectedEmojiSets = OSAllocatedUnfairLock<[EmojiSet]>(initialState: [])

    public var emojiSets: [EmojiSet] {
        protectedEmojiSets.withLock(\.self)
    }

    private init() {
        let groups = loadEmojiGroup()
        let emojiSets = groups.reduce(into: [EmojiSet]()) { partialResult, group in
            guard let category = EmojiCategory(groupName: group.name) else {
                return
            }
            let emojis = group.subgroups.flatMap(\.emojis)
            if partialResult.last?.category == category {
                partialResult[partialResult.count - 1].emojis += emojis
            } else {
                partialResult.append(EmojiSet(category: category, emojis: emojis))
            }
        }
        protectedEmojiSets.withLock { $0 = emojiSets }
    }

    private func loadEmojiGroup() -> [EmojiGroup] {
        guard let path = Bundle.module.path(forResource: "14.0-emoji-test", ofType: "txt"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
              let text = String(data: data, encoding: .utf8) else {
            fatalError("Could not get data from 14.0-emoji-test.txt")
        }
        var groups = [EmojiGroup]()
        var subgroups = [EmojiSubGroup]()
        var emojis = [Emoji]()
        text.enumerateLines { line, stop in
            if line.contains("# group:"),
               let group = line.components(separatedBy: "# group:").last?.trimmingCharacters(in: .whitespaces) {
                subgroups = []
                groups.append(EmojiGroup(name: group, subgroups: []))
            }
            if line.contains("# subgroup:"),
               let subGroup = line.components(separatedBy: "# subgroup:").last?.trimmingCharacters(in: .whitespaces) {
                emojis = []
                subgroups.append(EmojiSubGroup(name: subGroup, emojis: []))
                groups[groups.count - 1].subgroups = subgroups
            }
            if line.contains(";") && !line.contains("Format:") {
                let separatedBySemicolon = line.split(separator: ";")
                if let separatedByHash = separatedBySemicolon.last?.split(separator: "#"),
                   let status = separatedByHash.first?.trimmingCharacters(in: .whitespaces),
                   let afterHash = separatedByHash.last?.trimmingCharacters(in: .whitespaces),
                   let emoji = afterHash.components(separatedBy: .whitespaces).first {
                    guard status != "unqualified" && status != "minimally-qualified" else {
                        return
                    }
                    guard !afterHash.contains(":") || !afterHash.contains("skin tone") else {
                        return
                    }
                    var array = afterHash.components(separatedBy: " ")
                    array.removeFirst()
                    array.removeFirst()
                    let id = array.map { $0.replacingOccurrences(of: ":", with: "") }.joined(separator: "-")
                    emojis.append(Emoji(id: id, character: emoji))
                    subgroups[subgroups.count - 1].emojis = emojis
                    groups[groups.count - 1].subgroups = subgroups
                }
            }
        }
        return groups
    }

    public func randomEmoji(categories: [EmojiCategory] = EmojiCategory.allCases) -> Emoji? {
        protectedEmojiSets.withLock(\.self)
            .filter { categories.contains($0.category) }
            .randomElement()?
            .emojis
            .randomElement()
    }
}
