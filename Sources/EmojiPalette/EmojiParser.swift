/*
 EmojiParser.swift


 Created by Takuto Nakamura on 2023/09/10.

*/

import SwiftUI

final class EmojiParser {
    static let shared = EmojiParser()

    private var _emojiSet = [EmojiSet]()

    var emojiSet: [EmojiSet] {
        return _emojiSet
    }

    private init() {
        let groups = loadEmojiGroup()
        groups.forEach { group in
            guard let category = EmojiCategory(groupName: group.name) else {
                return
            }
            let emojis = group.subgroups.flatMap { $0.emojis }
            if _emojiSet.last?.category == category {
                _emojiSet[_emojiSet.count - 1].emojis += emojis
            } else {
                _emojiSet.append(EmojiSet(category: category, emojis: emojis))
            }
        }
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
                    if status == "unqualified" || status == "minimally-qualified" {
                        return
                    }
                    if afterHash.contains(":") && afterHash.contains("skin tone") {
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
}
