import ProjectDescription
import Foundation

extension Project {

    public static func app(folder: String) -> Project {


    let targetActions = [
        TargetAction.pre(path: "Scripts/SwiftLintRunScript.sh",
                        arguments: [],
                        name: "SwiftLint"),

        TargetAction.pre(path: "Scripts/RSwiftRunScript.sh",
                        arguments: [],
                        name: "R.Swift",
                        inputPaths: [Path.init("$TEMP_DIR/rswift-lastrun")],
                        inputFileListPaths: [],
                        outputPaths: [Path.init("$SRCROOT/R.generated.swift")],
                        outputFileListPaths: [])
]


        return Project(name: folder,
                       organizationName: "MyCompany",
        packages: [
                .package(url: "https://github.com/DaveWoodCom/XCGLogger.git", .upToNextMajor(from: "7.0.1")),
        ],
        settings: Settings.init(configurations: [
        .debug(name: "Debug DEV"),
        .debug(name: "Debug ITG"),
        .debug(name: "Debug PRP"),
        .debug(name: "Debug PROD"),
        .release(name: "Release DEV"),
        .release(name: "Release ITG"),
        .release(name: "Release PRP"),
        .release(name: "Release PROD")
    ]),
        targets: [
        Target(name: folder,
                    platform: .iOS,
                    product: .app,
                    bundleId: "com.demoapp",
                    infoPlist: InfoPlist.file(path: "Base/Support/Info.plist"),
                    sources: ["Base/Core/**","Base/Features/**","\(folder)/Sources/ViewController.swift"],
                    resources: ["Base/Resources/**","\(folder)/Resources/**"],
                    actions: targetActions,
                    dependencies: [
                        .package(product: "XCGLogger"),
                        .cocoapods(path: ".")
                   ]
                    ),
        Target(name: "\(folder)Tests",
                    platform: .iOS,
                    product: .unitTests,
                    bundleId: "com.demoapptests",
                    infoPlist: "Base/Tests/Info.plist",
                    sources: ["Base/Tests/**"],
                    dependencies: [
                        .target(name: folder)
                   ]
                   )
        ],
            additionalFiles: [
                    "R.generated.swift"
            ])
    }
}
