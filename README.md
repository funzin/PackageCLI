## Overview
If you want to manage multiple tools in Swift Package Manager, you need to be careful.
Here is a repository describing about them.

## Environment
- Xcode12.5(Swift5.4)

## Folder structure
```
./
├── CLI
│   ├── Package.swift
│   ├── _swiftgen
│   │   ├── Package.resolved
│   │   └── Package.swift
│   └── _xcodegen
│       ├── Package.resolved
│       └── Package.swift
└── README.md
```

## Problem 
If you use `CLI/Package.swift`, some dependent libraries may not be resolved.

```Package.swift
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
```

In this example, we can't resolve about the PathKit that SwiftGen and XcodeGen depend on.
```
$ swift run --package-path CLI -c release xcodegen 
error: Dependencies could not be resolved because root depends on 'SwiftGen' 6.4.0 and root depends on 'xcodegen' 2.22.0.
'xcodegen' is incompatible with 'SwiftGen' because 'xcodegen' >= 2.6.0 depends on 'PathKit' 1.0.0..<2.0.0 and 'SwiftGen' depends on 'PathKit' 0.9.0..<1.0.0.
```

## Solution
If you want to solve the above problem, you should prepare `Package.swift` for each tool.

### SwiftGen

```Package.swift
// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "_swiftgen",
    dependencies: [
        .package(url: "https://github.com/SwiftGen/SwiftGen", .exact("6.4.0"))
    ]
)
```

```
$ swift run --package-path CLI/_swiftgen -c release swiftgen
```

### XcodeGen

```Package.swift
// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "_xcodegen",
    dependencies: [
        .package(url: "https://github.com/yonaskolb/xcodegen", .exact("2.22.0"))
    ]
)
```

```
$ swift run --package-path CLI/_xcodegen -c release xcodegen 
```
