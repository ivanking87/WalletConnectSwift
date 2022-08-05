// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "WalletConnectSwiftMy",
    platforms: [
        .macOS(.v10_14), .iOS(.v13),
    ],
    products: [
        .library(
            name: "WalletConnectSwiftMy",
            targets: ["WalletConnectSwift"])
    ],
    dependencies: [
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .upToNextMinor(from: "1.5.1"))
    ],
    targets: [
        .target(
            name: "WalletConnectSwiftMy", 
            dependencies: ["CryptoSwift"],
            path: "Sources"),
        .testTarget(name: "WalletConnectSwiftTests", dependencies: ["WalletConnectSwiftMy"], path: "Tests"),
    ],
    swiftLanguageVersions: [.v5]
)
