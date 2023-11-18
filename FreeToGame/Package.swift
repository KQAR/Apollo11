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
      .package(url: "https://github.com/onevcat/Kingfisher.git", exact: "7.10.0"),
      .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", exact: "1.4.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "FreeToGame",
            dependencies: [
              .Kingfisher,
              .TCA,
            ]),
        .testTarget(
            name: "FreeToGameTests",
            dependencies: ["FreeToGame"]),
    ]
)

extension Target.Dependency {
  static let Kingfisher = Self.product(name: "Kingfisher", package: "Kingfisher")
  static let TCA = Self.product(name: "ComposableArchitecture", package: "swift-composable-architecture")
}
