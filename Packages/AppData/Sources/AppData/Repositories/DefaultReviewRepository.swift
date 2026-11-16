import Domain
import Foundation

public final class DefaultReviewRepository: ReviewRepository {
    private let client: HTTPClient
    private let decoder: JSONDecoder

    public init(client: HTTPClient = URLSessionHTTPClient(), decoder: JSONDecoder = JSONDecoder()) {
        self.client = client
        self.decoder = decoder
    }

    public func fetchReviews(appID: String) async throws -> [Review] {
        let data = try await client.data(from: URLMaker.review(id: appID))
        let response = try decoder.decode(ReviewsFeedResponse.self, from: data)
        return response.toDomain()
    }
}
