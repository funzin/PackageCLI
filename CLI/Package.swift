// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "CLI",
    dependencies: [
        .package(url: "https://github.com/SwiftGen/SwiftGen", .exact("6.4.0")),
        .package(url: "https://github.com/yonaskolb/xcodegen", .exact("2.22.0"))
    ]
)
