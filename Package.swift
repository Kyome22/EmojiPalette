// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "EmojiPalette",
    defaultLocalization: "en",
    platforms: [
        .iOS("16.4"),
    ],
    products: [
        .library(
            name: "EmojiPalette",
            targets: ["EmojiPalette"]
        ),
    ],
    targets: [
        .target(
            name: "EmojiPalette",
            resources: [.process("Resources")],
            swiftSettings: [.enableUpcomingFeature("ExistentialAny")]
        ),
    ]
)
