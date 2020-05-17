// swift-tools-version:5.2

import PackageDescription

let package = Package(
  name: "TinyConsole",
  platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
  products: [
    .library(name: "TinyConsoleCore", targets: ["TinyConsoleCore"]),
    .library(name: "TinyConsoleUI", targets: ["TinyConsoleUI"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
    .package(
      name: "TinyTree",
      url: "https://github.com/royhsu/tiny-tree.git",
      .branch("master")
    ),
  ],
  targets: [
    .target(
      name: "TinyConsoleCore",
      dependencies: [
        .product(name: "TinyTreeCore", package: "TinyTree"),
        .product(name: "Logging", package: "swift-log"),
      ]
    ),
    .target(
      name: "TinyConsoleUI",
      dependencies: [
        .target(name: "TinyConsoleCore"),
        .product(name: "TinyTreeCore", package: "TinyTree"),
        .product(name: "TinyTreeUI", package: "TinyTree"),
      ]
    ),
    .testTarget(name: "TinyConsoleUITests", dependencies: ["TinyConsoleUI"]),
  ]
)
