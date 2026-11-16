import Domain
import Foundation
import Testing

func makeAppDetails(id: Int, trackName: String) -> AppDetails {
    AppDetails(
        id: id,
        artistId: 1,
        screenshotUrls: ["https://example.com/shot.png"],
        iconUrl: "https://example.com/icon.png",
        advisories: [],
        supportedDevices: ["iPhone"],
        languageCodes: ["JA"],
        fileSizeBytes: "1",
        ageLimit: "4+",
        releaseDate: "2020-01-01T00:00:00Z",
        releaseNotes: "notes",
        primaryGenreId: 1,
        sellerName: "Seller",
        genres: ["Games"],
        currentVersionReleaseDateString: "2021-02-19T01:11:14Z",
        primaryGenreName: "Games",
        price: "無料",
        version: "1.0",
        trackName: trackName,
        description: "desc",
        averageUserRating: 4.5,
        userRatingCount: 10
    )
}

@MainActor
func waitUntil(
    timeoutNanoseconds: UInt64 = 1_000_000_000,
    pollNanoseconds: UInt64 = 10_000_000,
    condition: @MainActor () -> Bool
) async throws {
    let deadline = DispatchTime.now().uptimeNanoseconds + timeoutNanoseconds
    while DispatchTime.now().uptimeNanoseconds < deadline {
        if condition() {
            return
        }
        try await Task.sleep(nanoseconds: pollNanoseconds)
    }
    Issue.record("Timed out waiting for condition")
}

final class MockAppDetailsRepository: AppDetailsRepository {
    var detailsResult: AppDetails?
    var searchResult: [AppDetails]
    private(set) var searchTerms: [String] = []

    init(detailsResult: AppDetails? = nil, searchResult: [AppDetails] = []) {
        self.detailsResult = detailsResult
        self.searchResult = searchResult
    }

    func fetchAppDetails(id: String) async throws -> AppDetails? {
        detailsResult
    }

    func searchApps(term: String) async throws -> [AppDetails] {
        searchTerms.append(term)
        return searchResult
    }
}

final class MockAppsGroupRepository: AppsGroupRepository {
    private let results: [RankingChart: AppsGroup]
    private let failing: Set<RankingChart>

    init(results: [RankingChart: AppsGroup], failing: Set<RankingChart> = []) {
        self.results = results
        self.failing = failing
    }

    func fetchRanking(chart: RankingChart) async throws -> AppsGroup {
        if failing.contains(chart) {
            throw URLError(.badServerResponse)
        }
        guard let group = results[chart] else {
            throw URLError(.fileDoesNotExist)
        }
        return group
    }
}

final class MockReviewRepository: ReviewRepository {
    private let reviews: [Review]

    init(reviews: [Review]) {
        self.reviews = reviews
    }

    func fetchReviews(appID: String) async throws -> [Review] {
        reviews
    }
}
