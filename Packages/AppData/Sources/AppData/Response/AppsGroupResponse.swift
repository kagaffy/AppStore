import Domain
import Foundation

/// 旧 iTunes RSS (`itunes.apple.com/jp/rss/.../json`) のランキング feed。
struct AppsGroupResponse: Decodable {
    let feed: Feed

    struct Feed: Decodable {
        let entry: RSSArray<Entry>
    }

    struct Entry: Decodable {
        let name: RSSLabel
        let artist: RSSLabel
        let id: AppID
        let images: [RSSImage]

        enum CodingKeys: String, CodingKey {
            case name = "im:name"
            case artist = "im:artist"
            case id
            case images = "im:image"
        }

        struct AppID: Decodable {
            let attributes: Attributes

            struct Attributes: Decodable {
                let imId: String

                enum CodingKeys: String, CodingKey {
                    case imId = "im:id"
                }
            }
        }

        struct RSSImage: Decodable {
            let label: String
            let attributes: HeightAttributes?

            struct HeightAttributes: Decodable {
                let height: String
            }
        }

        var preferredIconURL: URL? {
            let sorted = images.sorted {
                (Int($0.attributes?.height ?? "0") ?? 0) < (Int($1.attributes?.height ?? "0") ?? 0)
            }
            guard let last = sorted.last else { return nil }
            return URL(string: last.label)
        }
    }

    func toDomain(title: String) -> AppsGroup {
        let apps: [App] = feed.entry.elements.compactMap { entry in
            guard let iconURL = entry.preferredIconURL else { return nil }
            return App(
                id: entry.id.attributes.imId,
                name: entry.name.label,
                artistName: entry.artist.label,
                iconUrl: iconURL
            )
        }
        return AppsGroup(title: title, apps: apps)
    }
}
