import ProjectDescription

extension Project {

    public static func app(folder: String) -> Project {
        return Project(name: "Project", organizationName: "MyCompany", targets: [
        Target(name: folder,
                    platform: .iOS,
                    product: .app,
                    bundleId: "com.demoapp",
                    infoPlist: InfoPlist.file(path: "Base/Resources/Info.plist"),
                    sources: ["Base/Core/**","Base/Features/**","\(folder)/Sources/ViewController.swift"],
                    resources: ["Base/Resources/**","\(folder)/Resources/**"]
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
        ])
    }
}
