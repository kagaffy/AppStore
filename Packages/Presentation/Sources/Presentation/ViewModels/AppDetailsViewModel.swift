import Combine
import Domain
import Foundation

@MainActor
public final class AppDetailsViewModel: ObservableObject {
    @Published public private(set) var appDetails: AppDetailsModel?
    @Published public private(set) var reviews: [ReviewModel] = []

    public let appID: String

    private let fetchAppDetails: FetchAppDetailsUseCase
    private let fetchReviews: FetchReviewsUseCase
    private var loadTask: Task<Void, Never>?

    public init(
        appID: String,
        fetchAppDetails: FetchAppDetailsUseCase,
        fetchReviews: FetchReviewsUseCase
    ) {
        self.appID = appID
        self.fetchAppDetails = fetchAppDetails
        self.fetchReviews = fetchReviews
    }

    public func load() {
        loadTask?.cancel()
        loadTask = Task { [weak self] in
            guard let self else { return }
            async let details: Void = self.loadDetails()
            async let reviews: Void = self.loadReviews()
            _ = await(details, reviews)
        }
    }

    private func loadDetails() async {
        do {
            guard let entity = try await fetchAppDetails.execute(id: appID) else { return }
            guard !Task.isCancelled else { return }
            appDetails = AppDetailsModel(entity: entity)
        } catch {}
    }

    private func loadReviews() async {
        do {
            let entities = try await fetchReviews.execute(appID: appID)
            guard !Task.isCancelled else { return }
            reviews = entities.map(ReviewModel.init(entity:))
        } catch {
            guard !Task.isCancelled else { return }
            reviews = []
        }
    }
}
