import Domain
import Foundation
import Presentation
import Testing

@MainActor
@Test
func appDetailsViewModelLoadsDetailsAndReviews() async throws {
    let details = makeAppDetails(id: 42, trackName: "Demo")
    let reviews = [
        Review(id: 1, name: "A", rating: "5", title: "Great", content: "Nice"),
    ]
    let detailsRepository = MockAppDetailsRepository(detailsResult: details)
    let reviewRepository = MockReviewRepository(reviews: reviews)
    let viewModel = AppDetailsViewModel(
        appID: "42",
        fetchAppDetails: FetchAppDetailsUseCase(repository: detailsRepository),
        fetchReviews: FetchReviewsUseCase(repository: reviewRepository)
    )

    viewModel.load()
    try await waitUntil { viewModel.appDetails != nil && !viewModel.reviews.isEmpty }

    #expect(viewModel.appDetails?.id == 42)
    #expect(viewModel.appDetails?.trackName == "Demo")
    #expect(viewModel.reviews.count == 1)
    #expect(viewModel.reviews[0].title == "Great")
}
