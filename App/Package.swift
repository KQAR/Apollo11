// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Apollo11",
  platforms: [.iOS(.v16)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(name: "App", targets: ["App"]),
    .library(name: "SentencePandect", targets: ["SentencePandect"]),
    .library(name: "Calendar", targets: ["Calendar"]),
    .library(name: "Debug", targets: ["Debug"]),
    .library(name: "Extensions", targets: ["Extensions"]),
    .library(name: "FreeToGame", targets: ["FreeToGame"]),
    .library(name: "OCR", targets: ["OCR"]),
    .library(name: "Pasteboard", targets: ["Pasteboard"]),
    .library(name: "Popup", targets: ["Popup"]),
    .library(name: "Profile", targets: ["Profile"]),
    .library(name: "ViewComponents", targets: ["ViewComponents"]),
    .library(name: "Spline", targets: ["Spline"]),
    .library(name: "Widget", targets: ["Widget"])
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    .package(url: "https://github.com/onevcat/Kingfisher.git", exact: "7.10.0"),
    .package(url: "https://github.com/Alamofire/Alamofire.git", exact: "5.8.0"),
    .package(url: "https://github.com/aheze/Setting.git", exact: "1.0.1"),
    .package(url: "https://github.com/Lakr233/ColorfulX.git", exact: "2.2.4"),
    .package(url: "https://github.com/costachung/neumorphic.git", branch: "master"),
    .package(url: "https://github.com/Boris-Em/ColorKit.git", exact: "1.0.0"),
    .package(url: "https://github.com/SFSafeSymbols/SFSafeSymbols.git", exact: "4.1.1"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", branch: "observation-beta"),
    .package(url: "https://github.com/exyte/PopupView.git", exact: "2.8.3"),
    .package(url: "https://github.com/splinetool/spline-ios.git", branch: "main")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "App",
      dependencies: [
        .SFSafeSymbols,
        .TCA,
        .SentencePandect,
        .FreeToGame,
        .ViewComponents,
        .Profile,
        .Calendar,
        .Spline
      ]),
    .target(
      name: "SentencePandect",
      dependencies: [
        .TCA,
        .Pasteboard,
        .Debug,
        .OCR,
        .Popup,
        .Extensions,
        .PopupView
      ]),
    .target(
      name: "Calendar",
      dependencies: [
        .TCA,
        .Neumorphic
      ]),
    .target(
      name: "Debug",
      dependencies: [
        .TCA
      ]),
    .target(
      name: "Extensions",
      dependencies: [
        .TCA
      ]),
    .target(
      name: "FreeToGame", 
      dependencies: [
        .TCA,
        .Alamofire,
        .Debug,
        .SFSafeSymbols,
        .Extensions,
        .Kingfisher
      ]),
    .target(
      name: "OCR", 
      dependencies: [
        .TCA
      ]),
    .target(
      name: "Pasteboard", 
      dependencies: [
        .Debug
      ]),
    .target(
      name: "Popup", 
      dependencies: [
        .TCA,
        .ColorKit,
        .Debug,
        .Pasteboard
      ]),
    .target(
      name: "Profile", 
      dependencies: [
        .TCA,
        .Setting,
        .ColorfulX
      ]),
    .target(
      name: "ViewComponents", 
      dependencies: [
        .TCA
      ]),
    .target(
      name: "Spline",
      dependencies: [
        .SplineRuntime
      ]),
    .target(
      name: "Widget",
      dependencies: [
        .Neumorphic
      ]
    ),
    .testTarget(name: "AppTests", dependencies: ["App"]),
  ]
)

extension Target.Dependency {
  static let SentencePandect: Target.Dependency = "SentencePandect"
  static let Pasteboard: Target.Dependency = "Pasteboard"
  static let Debug: Target.Dependency = "Debug"
  static let OCR: Target.Dependency = "OCR"
  static let Popup: Target.Dependency = "Popup"
  static let Extensions: Target.Dependency = "Extensions"
  static let FreeToGame: Target.Dependency = "FreeToGame"
  static let ViewComponents: Target.Dependency = "ViewComponents"
  static let Profile: Target.Dependency = "Profile"
  static let Calendar: Target.Dependency = "Calendar"
  static let Spline: Target.Dependency = "Spline"
  static let Alamofire = Self.product(name: "Alamofire", package: "Alamofire")
  static let Kingfisher = Self.product(name: "Kingfisher", package: "Kingfisher")
  static let Setting = Self.product(name: "Setting", package: "Setting")
  static let ColorfulX = Self.product(name: "ColorfulX", package: "ColorfulX")
  static let Neumorphic = Self.product(name: "Neumorphic", package: "Neumorphic")
  static let ColorKit = Self.product(name: "ColorKit", package: "ColorKit")
  static let PopupView = Self.product(name: "PopupView", package: "PopupView")
  static let SFSafeSymbols = Self.product(name: "SFSafeSymbols", package: "SFSafeSymbols")
  static let TCA = Self.product(name: "ComposableArchitecture", package: "swift-composable-architecture")
  static let SplineRuntime = Self.product(name: "SplineRuntime", package: "spline-ios")
}
