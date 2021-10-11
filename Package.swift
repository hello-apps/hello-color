// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "HelloColors",
    platforms: [.iOS(.v15), .macOS(.v12), .tvOS(.v15), .watchOS(.v8), .macCatalyst(.v15)],
    products: [
        .library(
            name: "HelloColors",
            targets: ["HelloColors"]),
    ],
    targets: [
        .target(
            name: "HelloColors"),
        .testTarget(
            name: "HelloColorsTests",
            dependencies: ["HelloColors"]),
    ]
)
