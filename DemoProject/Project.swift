import ProjectDescription
import ProjectDescriptionHelpers
import Foundation


func infosAppForFolder() -> InfoApp {
    
    var folder = "DemoApp"
    if case let .string(environmentAppFolder) = Environment.appFolder {
        folder = environmentAppFolder
    }
    
    let path = Path.relativeToManifest("\(folder)/infoApp.json").pathString
    if FileManager.default.fileExists(atPath: path),let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),let resultInfoApp = try? InfoApp.decode(data: data) {
        return resultInfoApp
        
    } else {
        return InfoApp()
    }
}


let project = Project.app(infosApp: infosAppForFolder())
