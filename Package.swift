// swift-tools-version:5.5
import PackageDescription
import Foundation

let swiftUIConveniencePackage: Package.Dependency
if FileManager.default.fileExists(atPath: "Users/adrian/Repos/swift-packages/swiftui-convenience") {
  swiftUIConveniencePackage = .package(name: "SwiftUIConvenience",
                               path: "~/Repos/swift-packages/swiftui-convenience")
} else {
  swiftUIConveniencePackage = .package(name: "SwiftUIConvenience",
                               url: "https://github.com/hello-apps/swiftui-convenience",
                               branch: "main")
}

let dependencies: [Package.Dependency] = [
  swiftUIConveniencePackage
]

let package = Package(
    name: "HelloColor",
    platforms: [.iOS(.v15), .macOS(.v12), .tvOS(.v15), .watchOS(.v8), .macCatalyst(.v15)],
    products: [
        .library(
            name: "HelloColor",
            targets: ["HelloColor"]),
    ],
    dependencies: dependencies,
    targets: [
        .target(
          name: "HelloColor",
          dependencies: [
            .byNameItem(name: "SwiftUIConvenience", condition: nil),
          ]),
        .testTarget(
            name: "HelloColorTests",
            dependencies: ["HelloColor"]),
    ]
)
