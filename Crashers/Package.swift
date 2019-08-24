// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "BuildSwiftOnARM",
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/SwiftyJSON.git", from: "17.0.2")
    ],
    targets: [
        .testTarget(
            name: "buildSwiftOnARMTests",
            dependencies: ["SwiftyJSON"]
	)
    ]
)
