/*
 EmojiCategory.swift
 

 Created by Takuto Nakamura on 2023/09/11.
 
*/

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

    public var label: String {
        switch self {
        case .smileysAndPeople:
            return "Smileys & People"
        case .animalsAndNature:
            return "Animals & Nature"
        case .foodAndDrink:
            return "Food & Drink"
        case .activity:
            return "Activity"
        case .travelAndPlaces:
            return "Travel & Places"
        case .objects:
            return "Objects"
        case .symbols:
            return "Symbols"
        case .flags:
            return "Flags"
        }
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

    init?(jsonCategoryType: JsonCategoryType) {
        switch jsonCategoryType {
        case .people:   self = .smileysAndPeople
        case .nature:   self = .animalsAndNature
        case .foods:    self = .foodAndDrink
        case .activity: self = .activity
        case .places:   self = .travelAndPlaces
        case .objects:  self = .objects
        case .symbols:  self = .symbols
        case .flags:    self = .flags
        }
    }
}
