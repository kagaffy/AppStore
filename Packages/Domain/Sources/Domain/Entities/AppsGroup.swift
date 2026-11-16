import Foundation

// NOTE(architecture): `AppsGroup` も Domain に置きつつ feed JSON を直接 Decodable している。
// 検討: `AppsGroupResponse`（AppData）へデコードし `toDomain()` で本型へ写す形に寄せる。
// `App` と同様、一旦このままでよい。
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
