import Foundation

public struct AppsGroup: Decodable, Equatable, Sendable {
    public var title: String {
        feed.title
    }

    public var apps: [App] {
        feed.results
    }

    private let feed: Feed

    public init(title: String, apps: [App]) {
        feed = Feed(title: title, results: apps)
    }

    private struct Feed: Decodable, Equatable, Sendable {
        let title: String
        let results: [App]
    }
}
