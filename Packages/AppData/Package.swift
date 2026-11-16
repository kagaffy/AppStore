// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AppData",
    platforms: [
        .iOS(.v18),
    ],
    products: [
        .library(name: "AppData", targets: ["AppData"]),
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "5.0.0"),
        .package(url: "https://github.com/malcommac/Hydra.git", from: "2.0.5"),
    ],
    targets: [
        .target(
            name: "AppData",
            dependencies: [
                "Domain",
                "SwiftyJSON",
                .product(name: "Hydra", package: "Hydra"),
            ]
        ),
        .testTarget(
            name: "AppDataTests",
            dependencies: ["AppData", "Domain"]
        ),
    ]
)
