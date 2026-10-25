import AppData
import Domain
import Foundation

/// Application composition root. Wires AppData implementations to Domain protocols.
/// Controllers still call legacy `Get*` APIs in Phase 1; migrate them to these use cases in Phase 2–3.
enum CompositionRoot {
    static let appsGroupRepository: AppsGroupRepository = DefaultAppsGroupRepository()
    static let appDetailsRepository: AppDetailsRepository = DefaultAppDetailsRepository()
    static let reviewRepository: ReviewRepository = DefaultReviewRepository()

    static var fetchAppsGroupUseCase: FetchAppsGroupUseCase {
        FetchAppsGroupUseCase(repository: appsGroupRepository)
    }

    static var fetchAppDetailsUseCase: FetchAppDetailsUseCase {
        FetchAppDetailsUseCase(repository: appDetailsRepository)
    }

    static var searchAppsUseCase: SearchAppsUseCase {
        SearchAppsUseCase(repository: appDetailsRepository)
    }

    static var fetchReviewsUseCase: FetchReviewsUseCase {
        FetchReviewsUseCase(repository: reviewRepository)
    }
}
