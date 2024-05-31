// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Data",
            targets: ["Data"]),
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../Core"),
        .package(url: "https://github.com/apollographql/apollo-ios", exact: "1.0.7"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Data",
            dependencies: [
                .product(name: "Apollo", package: "apollo-ios"),
                .target(name: "Graph"),
                .product(name: "Domain", package: "Domain"),
                .product(name: "Core", package: "Core")
            ]
        ),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data"]
        ),
        .target(
            name: "Graph",
            dependencies: [
                .product(name: "ApolloAPI", package: "apollo-ios")
            ]
        )
    ]
)
