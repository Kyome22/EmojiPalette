/*
 EmojiCategory.swift
 

 Created by Takuto Nakamura on 2023/09/11.
 
*/

import SwiftUI

public enum EmojiCategory: String, Identifiable, CaseIterable {
    case smileysAndPeople
    case animalsAndNature
    case foodAndDrink
    case activity
    case travelAndPlaces
    case objects
    case symbols
    case flags

    public var id: String {
        return rawValue
    }

    public var label: LocalizedStringKey {
        return LocalizedStringKey(rawValue)
    }

    public var imageName: String {
        switch self {
        case .smileysAndPeople:
            return "face.smiling"
        case .animalsAndNature:
            return "teddybear"
        case .foodAndDrink:
            return "fork.knife"
        case .activity:
            return "basketball"
        case .travelAndPlaces:
            return "car"
        case .objects:
            return "lightbulb"
        case .symbols:
            return "music.note"
        case .flags:
            return "flag"
        }
    }

    init?(groupName: String) {
        switch groupName {
        case "Smileys & Emotion": self = .smileysAndPeople
        case "People & Body": self = .smileysAndPeople
        case "Animals & Nature": self = .animalsAndNature
        case "Food & Drink": self = .foodAndDrink
        case "Travel & Places": self = .travelAndPlaces
        case "Activities": self = .activity
        case "Objects": self = .objects
        case "Symbols": self = .symbols
        case "Flags": self = .flags
        default: return nil
        }
    }
}
