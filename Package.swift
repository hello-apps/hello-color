// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "HelloColor",
    platforms: [.iOS(.v15), .macOS(.v12), .tvOS(.v15), .watchOS(.v8), .macCatalyst(.v15)],
    products: [
        .library(
            name: "HelloColor",
            targets: ["HelloColor"]),
    ],
    targets: [
        .target(
            name: "HelloColor"),
        .testTarget(
            name: "HelloColorTests",
            dependencies: ["HelloColor"]),
    ]
)
