// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "DisplayMode",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .executable(
            name: "displayrcd",
            targets: ["displayrcd"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.0"),
    ],
    targets: [
        .target(
            name: "displayrcd",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
    ]
)
