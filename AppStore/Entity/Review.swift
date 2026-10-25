//
//  Review.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/12/25.
//

import SwiftyJSON

public struct Review {
    public let id: Int
    public var name: String
    public var rating: String
    public var title: String
    public var content: String

    public init?(_ json: JSON) {
        guard let name = json["author"]["name"]["label"].string else { return nil }
        guard let rating = json["im:rating"]["label"].string else { return nil }
        guard let title = json["title"]["label"].string else { return nil }
        guard let content = json["content"]["label"].string else { return nil }

        id = json["id"]["label"].intValue
        self.name = name
        self.rating = rating
        self.title = title
        self.content = content
    }

    public static func load(_ array: [JSON]) -> [Review] {
        array.compactMap { Review($0) }
    }
}

public class GetReviews: PromiseOperation<[Review]> {
    public init(id: String) {
        super.init()

        url = URLMaker.review(id: id)

        jsonResponse = { json in
            Review.load(json["feed"]["entry"].arrayValue)
        }
    }
}
