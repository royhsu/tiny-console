// swift-tools-version:5.2

import PackageDescription

let package = Package(
  name: "TinyConsole",
  platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
  products: [
    .library(name: "TinyConsoleCore", targets: ["TinyConsoleCore"]),
    .library(name: "TinyConsole", targets: ["TinyConsole"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
    .package(
      name: "TreeUI",
      url: "https://github.com/royhsu/tree-ui.git",
      .branch("master")
    ),
  ],
  targets: [
    .target(
      name: "TinyConsoleCore",
      dependencies: [
        .product(name: "TreeCore", package: "TreeUI"),
        .product(name: "TreeUI", package: "TreeUI"),
        .product(name: "Logging", package: "swift-log"),
      ]
    ),
    .target(name: "TinyConsole", dependencies: ["TinyConsoleCore"]),
    .testTarget(name: "TinyConsoleTests", dependencies: ["TinyConsole"]),
  ]
)
