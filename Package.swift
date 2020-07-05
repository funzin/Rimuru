// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Rimuru",
    products: [
        .executable(name: "rimuru", targets: ["Rimuru"]),
        .library(name: "RimuruCore", targets: ["RimuruCore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.2.0"),
        .package(url: "https://github.com/realm/SwiftLint", from: "0.39.2"),
    ],
    targets: [
        .target(
            name: "Rimuru",
            dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser"),
                           "RimuruCore"]),
        .target(
            name: "RimuruCore",
            dependencies: []),
        .testTarget(
            name: "RimuruCoreTests",
            dependencies: ["RimuruCore"]),
    ]
)
