import ProjectDescription
let folderAttribute: Template.Attribute = .required("folder")

let template = Template(
    description: "Template for Swiftlint configuration process",
    attributes: [
        folderAttribute
    ],
    files: [
        .file(path: ".swiftlint.yml",
              templatePath: "swiftlint.stencil"),
    ]
)
