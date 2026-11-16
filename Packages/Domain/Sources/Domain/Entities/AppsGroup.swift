import Foundation

public struct AppsGroup: Equatable, Sendable {
    public var title: String
    public var apps: [App]

    public init(title: String, apps: [App]) {
        self.title = title
        self.apps = apps
    }
}
