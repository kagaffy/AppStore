@testable import AppData
import Foundation
import Testing

@Test
func decodeReviewsFixture() throws {
    let data = try fixture("reviews_line")
    let response = try JSONDecoder().decode(ReviewsFeedResponse.self, from: data)
    let reviews = response.toDomain()

    #expect(!reviews.isEmpty)
    #expect(!reviews[0].name.isEmpty)
    #expect(!reviews[0].content.isEmpty)
}
