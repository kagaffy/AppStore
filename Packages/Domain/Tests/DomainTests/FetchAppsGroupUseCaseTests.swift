import Domain
import XCTest

final class FetchAppsGroupUseCaseTests: XCTestCase {
    func testExecuteReturnsRepositoryResult() async throws {
        let expected = AppsGroup(
            title: RankingChart.topFree.displayTitle,
            apps: [
                App(
                    id: "1",
                    name: "Demo",
                    artistName: "Artist",
                    iconUrl: URL(string: "https://example.com/icon.png")!
                ),
            ]
        )
        let repository = MockAppsGroupRepository(result: expected)
        let useCase = FetchAppsGroupUseCase(repository: repository)

        let group = try await useCase.execute(chart: .topFree)
        XCTAssertEqual(group, expected)
        XCTAssertEqual(repository.requestedCharts, [.topFree])
    }
}

private final class MockAppsGroupRepository: AppsGroupRepository {
    private let result: AppsGroup
    private(set) var requestedCharts: [RankingChart] = []

    init(result: AppsGroup) {
        self.result = result
    }

    func fetchRanking(chart: RankingChart) async throws -> AppsGroup {
        requestedCharts.append(chart)
        return result
    }
}
