// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ZombieDice",
    dependencies: [],
    targets: [
        .target(
            name: "ZombieDice",
            dependencies: ["SimpleDie"]),
        .target(
            name: "SimpleDie",
            dependencies: [])
    ]
)
