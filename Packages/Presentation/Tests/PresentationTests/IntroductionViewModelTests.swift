import Domain
import Foundation
import Presentation
import Testing

@MainActor
@Test
func introductionViewModelAppendsFetchedGroups() async throws {
    let free = try AppsGroup(
        title: RankingChart.topFree.displayTitle,
        apps: [
            App(
                id: "1",
                name: "Demo",
                artistName: "Artist",
                iconUrl: #require(URL(string: "https://example.com/icon.png"))
            ),
        ]
    )
    let repository = MockAppsGroupRepository(results: [.topFree: free])
    let viewModel = IntroductionViewModel(
        fetchAppsGroup: FetchAppsGroupUseCase(repository: repository),
        charts: [.topFree]
    )

    viewModel.load()
    try await waitUntil { !viewModel.appsGroups.isEmpty }

    #expect(viewModel.appsGroups.count == 1)
    #expect(viewModel.appsGroups[0].title == RankingChart.topFree.displayTitle)
    #expect(viewModel.appsGroups[0].apps[0].id == "1")
}

@MainActor
@Test
func introductionViewModelIgnoresFailedCharts() async throws {
    let repository = MockAppsGroupRepository(results: [:], failing: [.topPaid])
    let viewModel = IntroductionViewModel(
        fetchAppsGroup: FetchAppsGroupUseCase(repository: repository),
        charts: [.topPaid]
    )

    viewModel.load()
    try await Task.sleep(nanoseconds: 50_000_000)

    #expect(viewModel.appsGroups.isEmpty)
}
