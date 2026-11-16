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
    ],
    targets: [
        .target(
            name: "AppData",
            dependencies: [
                "Domain",
            ]
        ),
        .testTarget(
            name: "AppDataTests",
            dependencies: ["AppData", "Domain"],
            resources: [
                .process("Fixtures"),
            ]
        ),
    ]
)
