import Foundation

public final class FetchReviewsUseCase: @unchecked Sendable {
    private let repository: ReviewRepository

    public init(repository: ReviewRepository) {
        self.repository = repository
    }

    public func execute(appID: String) async throws -> [Review] {
        try await repository.fetchReviews(appID: appID)
    }
}
