import Foundation

/// Search 一覧行の表示データ。
public struct AppsSearchResultModel: Identifiable, Equatable, Sendable {
    public let id: Int
    public var trackName: String
    public var iconUrl: String
    public var screenshotUrls: [String]
    public var price: String
    public var userRatingCount: Int

    public init(
        id: Int,
        trackName: String,
        iconUrl: String,
        screenshotUrls: [String],
        price: String,
        userRatingCount: Int
    ) {
        self.id = id
        self.trackName = trackName
        self.iconUrl = iconUrl
        self.screenshotUrls = screenshotUrls
        self.price = price
        self.userRatingCount = userRatingCount
    }
}
