import Foundation

public struct AppsGroupModel: Equatable, Sendable {
    public var title: String
    public var apps: [AppModel]

    public init(title: String, apps: [AppModel]) {
        self.title = title
        self.apps = apps
    }
}
