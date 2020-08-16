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
    targets: [
        .target(
            name: "displayrcd",
            dependencies: []
        ),
    ]
)
