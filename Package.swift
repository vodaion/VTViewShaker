// swift-tools-version:5.5
/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Package manifest for VTViewShaker.
*/

import PackageDescription

let package = Package(
    name: "VTViewShaker",
    
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "VTViewShaker",
            targets: ["VTViewShaker"]
        )
    ],
    targets: [
        .target(
            name: "VTViewShaker",
            path: "Sources/"
        )
    ]
)
