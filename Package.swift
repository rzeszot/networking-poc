// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [
        .iOS(.v15),
        .macOS(.v10_15)
    ],
    products: [
       .library(
            name: "Networking",
            targets: ["Networking"]
       )
    ],
    targets: [
        .target(
            name: "Networking"
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]
        )
    ]
)
