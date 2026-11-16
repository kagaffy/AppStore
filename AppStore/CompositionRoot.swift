import AppData
import Domain
import Foundation
import Presentation

/// Application composition root. Wires AppData implementations to Domain protocols / Presentation ViewModels.
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

    @MainActor
    static func makeAppsSearchViewModel() -> AppsSearchViewModel {
        AppsSearchViewModel(searchApps: searchAppsUseCase)
    }

    @MainActor
    static func makeIntroductionViewModel(charts: [RankingChart]) -> IntroductionViewModel {
        IntroductionViewModel(fetchAppsGroup: fetchAppsGroupUseCase, charts: charts)
    }

    @MainActor
    static func makeAppDetailsViewModel(id: String) -> AppDetailsViewModel {
        AppDetailsViewModel(
            appID: id,
            fetchAppDetails: fetchAppDetailsUseCase,
            fetchReviews: fetchReviewsUseCase
        )
    }
}
