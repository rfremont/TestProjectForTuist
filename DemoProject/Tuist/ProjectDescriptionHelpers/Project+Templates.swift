import ProjectDescription
import Foundation

extension Project {

    public static func app(infosApp: InfoApp) -> Project {

        return Project(name: infosApp.appName,
                       organizationName: "MyCompany",
                       packages: infosApp.appPackages(),
                       settings: infosApp.appSettings(),
        targets: [
            Target(name: infosApp.appName,
                    platform: .iOS,
                    product: .app,
                    bundleId: infosApp.bundleId,
                    deploymentTarget: .iOS(targetVersion: "11.0", devices: .iphone) ,
                    infoPlist:infosApp.appInfoPlist(),
                    sources: ["Base/Core/**","Base/Features/**","\(infosApp.folder)/Sources/ViewController.swift"],
                    resources: ["Base/Resources/**","\(infosApp.folder)/Resources/**"],
                    actions: toolTargetActions(),
                    dependencies: infosApp.appTargetDependencies(),
                    settings: infosApp.appSettings()
                    ),
        Target(name: "\(infosApp.appName)Tests",
                    platform: .iOS,
                    product: .unitTests,
                    bundleId: "com.demoapptests",
                    infoPlist: "Base/Tests/Info.plist",
                    sources: ["Base/Tests/**"],
                    dependencies: [
                        .target(name: infosApp.appName)
                   ]
                   )
        ],
        additionalFiles: infosApp.additionalFiles()
        )
    }
    
    
    private static func toolTargetActions() -> [TargetAction] {
         return [
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
    }
}
