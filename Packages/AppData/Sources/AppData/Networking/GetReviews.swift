import Domain
import Foundation

@available(*, deprecated, message: "Prefer DefaultReviewRepository")
public final class GetReviews: PromiseOperation<[Review]> {
    public init(id: String) {
        super.init()
        url = URLMaker.review(id: id)
        jsonResponse = { json in
            ReviewDTO.load(json["feed"]["entry"].arrayValue)
        }
    }
}
