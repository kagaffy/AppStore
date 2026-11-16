import Foundation

/// iTunes RSS は件数 1 のとき配列ではなく単体オブジェクトになることがある。
struct RSSArray<Element: Decodable>: Decodable {
    let elements: [Element]

    init(from decoder: Decoder) throws {
        if let array = try? [Element](from: decoder) {
            elements = array
        } else if let single = try? Element(from: decoder) {
            elements = [single]
        } else {
            elements = []
        }
    }
}

struct RSSLabel: Decodable {
    let label: String
}
