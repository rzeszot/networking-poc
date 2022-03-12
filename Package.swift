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
             name: "Hated",
             targets: ["Hated"]
        ),
        .library(
            name: "Networking",
            targets: ["Networking"]
       )
    ],
    targets: [
        .target(
            name: "Hated"
        ),
        .target(
            name: "Networking"
        ),
        .testTarget(
            name: "HatedTests",
            dependencies: ["Hated", "Networking"]
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]
        )
    ]
)
