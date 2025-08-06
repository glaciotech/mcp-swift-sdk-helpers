// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MCPHelpers",
    platforms: [
        .macOS("13.0"),
        .macCatalyst("16.0"),
        .iOS("16.0"),
        .watchOS("9.0"),
        .tvOS("16.0"),
        .visionOS("1.0"),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MCPHelpers",
            targets: ["MCPHelpers"]),
    ],
    dependencies: [
        // Our code is designed to float on top of the official mcp library. As such we specify a wide range and let the user set exactly in the project
//        .package(url: "https://github.com/modelcontextprotocol/swift-sdk.git", "0.9.0" ..< "2.0.0"),

        // 6th Aug 2025 - The official version currently doesn't support instructions so we have to use our branch which pipes this through, move to official when supported
        .package(url: "https://github.com/glaciotech/mcp-swift-sdk.git", branch: "instruction-support"),

//        .package(path: "../../../Libraries/mcp-swift-sdk"),
        .package(url: "https://github.com/ptliddle/swifty-json-schema.git", branch: "develop"), // "0.2.0" ..< "0.5.0"),
//        .package(path: "../swifty-json-schema")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MCPHelpers",
            dependencies: [
                // Uncomment below for the official version
                // .product(name: "MCP", package: "swift-sdk"),
                .product(name: "MCP", package: "mcp-swift-sdk"),
                .product(name: "SwiftyJsonSchema", package: "swifty-json-schema")
            ]
        ),
        .testTarget(
            name: "MCPHelpersTests",
            dependencies: [
                "MCPHelpers",
                // Uncomment below for the official version
                // .product(name: "MCP", package: "swift-sdk"),
                .product(name: "MCP", package: "mcp-swift-sdk"),
                .product(name: "SwiftyJsonSchema", package: "swifty-json-schema")
            ]
        ),
    ]
)
