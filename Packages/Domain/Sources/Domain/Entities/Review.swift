import Foundation

public struct Review: Equatable, Identifiable, Sendable {
    public let id: Int
    public var name: String
    public var rating: String
    public var title: String
    public var content: String

    public init(id: Int, name: String, rating: String, title: String, content: String) {
        self.id = id
        self.name = name
        self.rating = rating
        self.title = title
        self.content = content
    }
}
