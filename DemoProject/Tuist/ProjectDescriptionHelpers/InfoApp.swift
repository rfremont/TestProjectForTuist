import ProjectDescription
import Foundation

public extension Decodable {
    static func decode(data: Data) throws -> Self {
        let decoder = JSONDecoder()
        return try decoder.decode(Self.self, from: data)
    }
}

public struct InfoApp: Codable {
    let version: String
    let folder: String
    let extraPackage: [Package]?
    let bundleId: String
    let appName: String
    
    public init(version: String = "", folder: String = "DemoApp", bundleId: String = "", appName: String = "") {
        self.version = version
        self.folder = folder
        self.extraPackage = nil
        self.bundleId = bundleId
        self.appName = appName
    }
    
    public func appDefaultSettings() -> SettingsDictionary {
        
        return SettingsDictionary()
            .bitcodeEnabled(false)
            .swiftCompilationMode(.wholemodule)
            .appleGenericVersioningSystem()
            .currentProjectVersion("1")
    }
    
    public enum TypeEnv {
        case debug
        case release
    }
    
    public func envSettingsFor(config: String, type: TypeEnv = .release) -> SettingsDictionary {
        let settings: [String: SettingValue] = [
            "PRODUCT_BUNDLE_IDENTIFIER": SettingValue(stringLiteral: "\(config == "prod" ? bundleId : bundleId + "." + config)"),
            "PRODUCT_NAME": SettingValue(stringLiteral: "\(config == "prod" ? appName : appName + " " + config.uppercased())"),
            "SWIFT_ACTIVE_COMPILATION_CONDITIONS": SettingValue(stringLiteral: "\(type == .debug ? "DEBUG" + " " + config.uppercased() : config.uppercased())"),
        ]
        return settings
    }
    
    public func appSettings() -> Settings {
        
        return Settings(base: appDefaultSettings(),
            configurations: [
                .debug(name: "Debug DEV", settings: envSettingsFor(config: "dev", type: .debug)),
            .debug(name: "Debug ITG", settings: envSettingsFor(config: "itg", type: .debug)),
            .debug(name: "Debug PRP", settings: envSettingsFor(config: "prp", type: .debug)),
            .debug(name: "Debug PROD", settings: envSettingsFor(config: "prod", type: .debug)),
            .release(name: "Release DEV", settings: envSettingsFor(config: "dev")),
            .release(name: "Release ITG", settings: envSettingsFor(config: "itg")),
            .release(name: "Release PRP", settings: envSettingsFor(config: "prp")),
            .release(name: "Release PROD", settings: envSettingsFor(config: "prod"))
            ]
            )
    }
    
    public func appPackages() -> [Package] {
        
        return [
            .package(url: "https://github.com/DaveWoodCom/XCGLogger.git", .upToNextMajor(from: "7.0.1"))
        ]
    }
    
    public func additionalFiles() -> [FileElement] {
        return [
            "R.generated.swift"
        ]
    }
    
    public func appTargetDependencies() -> [TargetDependency] {
        return [
            .package(product: "XCGLogger"),
            .cocoapods(path: ".")
       ]
    }
    
    public func appInfoPlist() -> InfoPlist {
        return .extendingDefault(with: [
            "CFBundleShortVersionString": InfoPlist.Value(stringLiteral:"\(version)")
        ])
    }
}
