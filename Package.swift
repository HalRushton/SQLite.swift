// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "SQLite.swift",
    products: [.library(name: "SQLite", targets: ["SQLite"]),
         .library(name: "SQLiteCipher", targets: ["SQLiteCipher"]),
    ],
    dependencies: [
        .package(name: "SQLCipher", url: "git@github.com:antwork/SQLCipher.git", from: "0.0.4"),
    ],
    targets: [
        .target(name: "SQLite", 
            dependencies: ["SQLiteObjc"]
        ),
        .target(name: "SQLiteCipher", 
            dependencies: ["SQLiteObjc", "SQLCipher"],
            path: "SQLite",
            cSettings: [.define("SQLITE_SWIFT_SQLCIPHER")],
            swiftSettings: [.define("SQLITE_SWIFT_SQLCIPHER")]
        ),
        .target(name: "SQLiteObjc"),
        .testTarget(name: "SQLiteTests", dependencies: ["SQLite"], path: "Tests/SQLiteTests")
    ],
    swiftLanguageVersions: [.v5]
)

#if os(Linux)
    package.dependencies = [.package(url: "https://github.com/stephencelis/CSQLite.git", from: "0.0.3")]
    package.targets = [
        .target(name: "SQLite", exclude: ["Extensions/FTS4.swift", "Extensions/FTS5.swift"]),
        .testTarget(name: "SQLiteTests", dependencies: ["SQLite"], path: "Tests/SQLiteTests", exclude: [
            "FTS4Tests.swift",
            "FTS5Tests.swift"
        ])
    ]
#endif
