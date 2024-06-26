// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Presentation",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Presentation",
            targets: ["Presentation"]
        ),
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../Core"),
        .package(url: "https://github.com/pointfreeco/swift-concurrency-extras", exact: "1.1.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Presentation",
            dependencies: [
                .product(name: "Domain", package: "Domain"),
                .product(name: "Core", package: "Core")
            ],
            resources: [
                .process("Theme/Assets.xcassets"),
                .process("Theme/Fonts")
            ]
        ),
        .testTarget(
            name: "PresentationTests",
            dependencies: [
                .target(name: "Presentation"),
                .product(name: "ConcurrencyExtras", package: "swift-concurrency-extras")
            ]
        ),
    ]
)
