import Domain
import Foundation

/// カスタマーレビュー RSS の feed。
struct ReviewsFeedResponse: Decodable {
    let feed: Feed

    struct Feed: Decodable {
        let entry: RSSArray<ReviewEntryResponse>
    }

    func toDomain() -> [Review] {
        // entry[0] はアプリ情報のことがあるため Review 化できるものだけ採用
        feed.entry.elements.compactMap(\.toDomain)
    }
}

struct ReviewEntryResponse: Decodable {
    let author: Author?
    let rating: RSSLabel?
    let title: RSSLabel?
    let content: Content?
    let id: RSSLabel?

    enum CodingKeys: String, CodingKey {
        case author
        case rating = "im:rating"
        case title
        case content
        case id
    }

    struct Author: Decodable {
        let name: RSSLabel?
    }

    struct Content: Decodable {
        let label: String
    }

    var toDomain: Review? {
        guard
            let name = author?.name?.label,
            let rating = rating?.label,
            let title = title?.label,
            let content = content?.label,
            let idLabel = id?.label,
            let id = Int(idLabel)
        else {
            return nil
        }
        return Review(id: id, name: name, rating: rating, title: title, content: content)
    }
}
