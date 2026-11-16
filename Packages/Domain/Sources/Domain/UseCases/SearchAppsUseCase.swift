import Foundation

public final class SearchAppsUseCase: @unchecked Sendable {
    private let repository: AppDetailsRepository

    public init(repository: AppDetailsRepository) {
        self.repository = repository
    }

    public func execute(term: String) async throws -> [AppDetails] {
        try await repository.searchApps(term: term)
    }
}
