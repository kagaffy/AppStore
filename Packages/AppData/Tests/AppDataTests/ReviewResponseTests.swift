@testable import AppData
import XCTest

final class ReviewResponseTests: XCTestCase {
    func testDecodeReviewsFixture() throws {
        let data = try fixture("reviews_line")
        let response = try JSONDecoder().decode(ReviewsFeedResponse.self, from: data)
        let reviews = response.toDomain()

        XCTAssertFalse(reviews.isEmpty)
        XCTAssertFalse(reviews[0].name.isEmpty)
        XCTAssertFalse(reviews[0].content.isEmpty)
    }
}
