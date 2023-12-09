// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FreeToGame",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "FreeToGame",
            targets: ["FreeToGame"]),
    ],
    dependencies: [
      .package(path: "Sources/Debug"),
      .package(path: "Sources/Extensions"),
      .package(url: "https://github.com/onevcat/Kingfisher.git", exact: "7.10.0"),
      .package(url: "https://github.com/Alamofire/Alamofire.git", exact: "5.8.0"),
      .package(url: "https://github.com/SFSafeSymbols/SFSafeSymbols.git", exact: "4.1.1"),
      .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", exact: "1.4.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "FreeToGame",
            dependencies: [
              "Debug",
              "Extensions",
              .Alamofire,
              .SFSafeSymbols,
              .Kingfisher,
              .TCA,
            ]),
        .testTarget(
            name: "FreeToGameTests",
            dependencies: ["FreeToGame"]),
    ]
)

extension Target.Dependency {
  static let Alamofire = Self.product(name: "Alamofire", package: "Alamofire")
  static let Kingfisher = Self.product(name: "Kingfisher", package: "Kingfisher")
  static let SFSafeSymbols = Self.product(name: "SFSafeSymbols", package: "SFSafeSymbols")
  static let TCA = Self.product(name: "ComposableArchitecture", package: "swift-composable-architecture")
}
