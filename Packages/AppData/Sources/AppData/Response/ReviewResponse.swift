import Domain
import SwiftyJSON

/// レビュー RSS の1件分（ネットワーク境界の型）。
enum ReviewResponse {
    static func make(from json: JSON) -> Review? {
        guard let name = json["author"]["name"]["label"].string else { return nil }
        guard let rating = json["im:rating"]["label"].string else { return nil }
        guard let title = json["title"]["label"].string else { return nil }
        guard let content = json["content"]["label"].string else { return nil }

        return Review(
            id: json["id"]["label"].intValue,
            name: name,
            rating: rating,
            title: title,
            content: content
        )
    }

    static func load(_ array: [JSON]) -> [Review] {
        array.compactMap { make(from: $0) }
    }
}
