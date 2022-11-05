// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MuFiles",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "MuFiles",
            targets: ["MuFiles"]),
    ],
    dependencies: [
        .package(url: "https://github.com/weichsel/ZIPFoundation", from: "0.9.15"),
    ],
    targets: [
        .target(
            name: "MuFiles",
            dependencies: [
                .product(name: "ZIPFoundation", package: "ZIPFoundation"),
            ]),
        .testTarget(
            name: "MuFilesTests",
            dependencies: ["MuFiles", "ZIPFoundation"]),
    ]
)
