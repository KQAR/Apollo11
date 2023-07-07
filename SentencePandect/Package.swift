// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SentencePandect",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SentencePandect",
            targets: ["SentencePandect"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
      .package(path: "Sources/OCR"),
      .package(path: "Sources/Debug"),
      .package(path: "Sources/Pasteboard"),
      .package(path: "Sources/Extensions"),
      .package(path: "Sources/Popup"),
      .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "0.54.0"),
      .package(url: "https://github.com/exyte/PopupView.git", from: "2.0.0"),
      .package(url: "https://github.com/siteline/SwiftUI-Introspect.git", from: "0.2.3")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SentencePandect",
            dependencies: []),
        .testTarget(
            name: "SentencePandectTests",
            dependencies: ["SentencePandect"]),
    ]
)
