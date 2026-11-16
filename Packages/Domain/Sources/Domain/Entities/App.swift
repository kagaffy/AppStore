import Foundation

// NOTE(architecture): `App` は Domain Entity だが、現状 `Codable` + API キー
// (`artworkUrl100` など) を抱えておりネットワーク境界と混在している。
// 検討: JSON 形は AppData の `AppResponse` に切り出し、Domain は Codable なしの
// Entity のみにする（`AppDetails` / `AppDetailsResponse` の分離が望ましい形）。
// 一旦このままでよい。変更するときは命名規則（Response / Entity / Model）に従う。
public struct App: Decodable, Identifiable, Equatable, Sendable {
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

    private enum Key: String, CodingKey {
        case id
        case name
        case artistName
        case iconUrl = "artworkUrl100"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        artistName = try container.decode(String.self, forKey: .artistName)
        iconUrl = try container.decode(URL.self, forKey: .iconUrl)
    }
}
