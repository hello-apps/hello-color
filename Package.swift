// swift-tools-version:5.6
import PackageDescription
import Foundation

var helloPackagesPath: String = #file
helloPackagesPath = String(helloPackagesPath[...helloPackagesPath.lastIndex(of: "/")!]) + "../"
if helloPackagesPath.hasPrefix("file://") {
  helloPackagesPath.removeFirst(7)
}

let swiftUIConveniencePackage: Package.Dependency
if FileManager.default.fileExists(atPath: "\(helloPackagesPath)swiftui-convenience") {
  swiftUIConveniencePackage = .package(name: "swiftui-convenience",
                                       path: "\(helloPackagesPath)swiftui-convenience")
} else {
  swiftUIConveniencePackage = .package(url: "https://github.com/hello-apps/swiftui-convenience",
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
            .product(name: "SwiftUIConvenience", package: "swiftui-convenience"),
          ],
          swiftSettings: [.define("APPLICATION_EXTENSION_API_ONLY")]),
        .testTarget(
            name: "HelloColorTests",
            dependencies: ["HelloColor"]),
    ]
)
