// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Profile",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Profile",
            targets: ["Profile"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
      .package(url: "https://github.com/aheze/Setting.git", exact: "1.0.1"),
      .package(url: "https://github.com/Lakr233/Colorful.git",exact: "1.1.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Profile",
            dependencies: [
              .Setting,
              .Colorful
            ]),
        .testTarget(
            name: "ProfileTests",
            dependencies: ["Profile"]),
    ]
)

extension Target.Dependency {
  static let Setting = Self.product(name: "Setting", package: "Setting")
  static let Colorful = Self.product(name: "Colorful", package: "Colorful")
}
