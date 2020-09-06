// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "vragen-sdk-network",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(name: "VragenSDKNetwork", targets: ["VragenSDKNetwork"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "14.0.0")),
        .package(url: "https://github.com/MartinMetselaar/vragen-api-models.git", from: "1.3.0"),
    ],
    targets: [
        .target(name: "VragenSDKNetwork", dependencies: [
            .product(name: "VragenAPIModels", package: "vragen-api-models"),
            .product(name: "Moya", package: "Moya"),
        ], path: "./Sources/Network"),

        .testTarget(name: "VragenSDKNetworkTests", dependencies: [
            .target(name: "VragenSDKNetwork"),
            .product(name: "Moya", package: "Moya"),
        ])
    ]
)
