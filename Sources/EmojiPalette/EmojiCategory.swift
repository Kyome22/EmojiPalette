/*
 EmojiCategory.swift
 

 Created by Takuto Nakamura on 2023/09/11.
 
*/

import SwiftUI

public enum EmojiCategory: String, Sendable, Identifiable, CaseIterable {
    case smileysAndPeople
    case animalsAndNature
    case foodAndDrink
    case activity
    case travelAndPlaces
    case objects
    case symbols
    case flags

    public var id: String { rawValue }

    public var label: LocalizedStringKey { .init(rawValue) }

    public var imageName: String {
        switch self {
        case .smileysAndPeople: "face.smiling"
        case .animalsAndNature: "teddybear"
        case .foodAndDrink:     "fork.knife"
        case .activity:         "basketball"
        case .travelAndPlaces:  "car"
        case .objects:          "lightbulb"
        case .symbols:          "music.note"
        case .flags:            "flag"
        }
    }

    init?(groupName: String) {
        switch groupName {
        case "Smileys & Emotion": self = .smileysAndPeople
        case "People & Body":     self = .smileysAndPeople
        case "Animals & Nature":  self = .animalsAndNature
        case "Food & Drink":      self = .foodAndDrink
        case "Travel & Places":   self = .travelAndPlaces
        case "Activities":        self = .activity
        case "Objects":           self = .objects
        case "Symbols":           self = .symbols
        case "Flags":             self = .flags
        default: return nil
        }
    }
}
