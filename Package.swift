// swift-tools-version:5.2

import PackageDescription

let package = Package(
  name: "TinyConsole",
  platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
  products: [
    .library(name: "TinyConsoleCore", targets: ["TinyConsoleCore"]),
    .library(
      name: "TinyConsoleCoreSwiftLog",
      targets: ["TinyConsoleCoreSwiftLog"]),
    .library(name: "TinyConsole", targets: ["TinyConsole"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
  ],
  targets: [
    .target(name: "TinyConsoleCore"),
    .target(
      name: "TinyConsoleCoreSwiftLog",
      dependencies: [.product(name: "Logging", package: "swift-log")]),
    .target(name: "TinyConsole", dependencies: ["TinyConsoleCore"]),
    .testTarget(name: "TinyConsoleTests", dependencies: ["TinyConsole"]),
  ]
)
