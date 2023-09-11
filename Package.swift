// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "EmojiPalette",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "EmojiPalette",
            targets: ["EmojiPalette"]
        )
    ],
    targets: [
        .target(
            name: "EmojiPalette",
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "EmojiPaletteTests",
            dependencies: ["EmojiPalette"]
        )
    ]
)
