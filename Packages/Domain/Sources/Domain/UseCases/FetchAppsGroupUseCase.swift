import Foundation

public final class FetchAppsGroupUseCase: @unchecked Sendable {
    private let repository: AppsGroupRepository

    public init(repository: AppsGroupRepository) {
        self.repository = repository
    }

    public func execute(chart: RankingChart) async throws -> AppsGroup {
        try await repository.fetchRanking(chart: chart)
    }
}
