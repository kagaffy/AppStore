import Foundation

public final class SearchAppsUseCase {
    private let repository: AppDetailsRepository

    public init(repository: AppDetailsRepository) {
        self.repository = repository
    }

    public func execute(term: String) async throws -> [AppDetails] {
        try await repository.searchApps(term: term)
    }
}
