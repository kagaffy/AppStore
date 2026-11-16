import Foundation

public struct App: Identifiable, Equatable, Sendable {
    public let id: String
    public var name: String
    public var artistName: String
    public var iconUrl: URL

    public init(id: String, name: String, artistName: String, iconUrl: URL) {
        self.id = id
        self.name = name
        self.artistName = artistName
        self.iconUrl = iconUrl
    }
}
