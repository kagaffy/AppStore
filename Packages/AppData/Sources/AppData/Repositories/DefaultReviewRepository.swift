import Domain
import Foundation
import Hydra

public final class DefaultReviewRepository: ReviewRepository {
    public init() {}

    public func fetchReviews(appID: String, completion: @escaping (Result<[Review], Error>) -> Void) {
        GetReviews(id: appID).execute(in: .background).then(in: .main) { reviews in
            completion(.success(reviews))
        }.catch(in: .main) { error in
            completion(.failure(error))
        }
    }
}
