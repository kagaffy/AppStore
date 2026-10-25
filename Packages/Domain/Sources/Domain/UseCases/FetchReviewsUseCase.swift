import Foundation

public final class FetchReviewsUseCase {
    private let repository: ReviewRepository

    public init(repository: ReviewRepository) {
        self.repository = repository
    }

    public func execute(appID: String, completion: @escaping (Result<[Review], Error>) -> Void) {
        repository.fetchReviews(appID: appID, completion: completion)
    }
}
