// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "TinyConsole",
  platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
  products: [
    .library(name: "TinyConsoleCore", targets: ["TinyConsoleCore"]),
    .library(name: "TinyConsole", targets: ["TinyConsole"]),
  ],
  targets: [
    .target(name: "TinyConsoleCore"),
    .target(name: "TinyConsole", dependencies: ["TinyConsoleCore"]),
    .testTarget(name: "TinyConsoleTests", dependencies: ["TinyConsole"]),
  ]
)
