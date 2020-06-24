// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SGCodeTextField",
    platforms: [.iOS(.v9), .tvOS(.v9)],
    products: [
        .library(
            name: "SGCodeTextField", targets: ["SGCodeTextField"]),
    ],
    targets: [
        .target(
            name: "SGCodeTextField",
            path: "Sources")
    ]
)
