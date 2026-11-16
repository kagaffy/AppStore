import Foundation

public protocol ReviewRepository: AnyObject {
    func fetchReviews(appID: String, completion: @escaping (Result<[Review], Error>) -> Void)
}
