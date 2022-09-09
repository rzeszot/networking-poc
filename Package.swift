// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "ResponseParser",
    platforms: [
        .iOS(.v15),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "ResponseParser",
            targets: ["ResponseParser"]
       )
    ],
    targets: [
        .target(
            name: "ResponseParser"
        ),
        .testTarget(
            name: "ResponseParserTests",
            dependencies: ["ResponseParser"]
        )
    ]
)
