import Foundation

public protocol ReviewRepository: AnyObject {
    func fetchReviews(appID: String) async throws -> [Review]
}
