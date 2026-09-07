// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-indexed",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: "Indexed", targets: ["Indexed"]),
        .library(name: "Indexed Standard Library Integration", targets: ["Indexed Standard Library Integration"]),
        .library(name: "Indexed Foundation Library Integration", targets: ["Indexed Foundation Library Integration"]),
        .library(name: "Indexed Test Support", targets: ["Indexed Test Support"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-index.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-property.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-cardinal.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-tagged.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-ordinal.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-affine.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Indexed",
            dependencies: [
                .product(name: "Index", package: "swift-index"),
                .product(name: "Property", package: "swift-property"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Tagged", package: "swift-tagged"),
                .product(name: "Ordinal", package: "swift-ordinal"),
                .product(name: "Affine", package: "swift-affine"),
            ],
            path: "Sources/Indexed"
        ),
        .target(
            name: "Indexed Standard Library Integration",
            dependencies: [
                .product(name: "Index", package: "swift-index"),
                .product(name: "Cardinal Standard Library Integration", package: "swift-cardinal"),
                .product(name: "Ordinal", package: "swift-ordinal"),
                .product(name: "Ordinal Standard Library Integration", package: "swift-ordinal"),
                .target(name: "Indexed"),
            ],
            path: "Sources/Indexed Standard Library Integration"
        ),
        .target(
            name: "Indexed Foundation Library Integration",
            dependencies: [
                .target(name: "Indexed"),
                .target(name: "Indexed Standard Library Integration"),
            ],
            path: "Sources/Indexed Foundation Library Integration"
        ),
        .target(
            name: "Indexed Test Support",
            dependencies: [
                .target(name: "Indexed"),
                .product(name: "Index Test Support", package: "swift-index"),
                .product(name: "Ordinal", package: "swift-ordinal"),
                .product(name: "Tagged", package: "swift-tagged"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Indexed Tests",
            dependencies: [
                .target(name: "Indexed"),
                .target(name: "Indexed Test Support"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Tagged", package: "swift-tagged"),
                .product(name: "Tagged Standard Library Integration", package: "swift-tagged"),
                .product(name: "Ordinal", package: "swift-ordinal"),
                .target(name: "Indexed Standard Library Integration"),
                .target(name: "Indexed Foundation Library Integration"),
            ],
            path: "Tests/Indexed Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
}
