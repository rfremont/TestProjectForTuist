import ProjectDescription
import ProjectDescriptionHelpers


func appFolder() -> String {
  if case let .string(environmentAppFolder) = Environment.appFolder {
    return environmentAppFolder
  } else {
    return "DemoApp"
  }
}

let project = Project.app(folder: appFolder())

