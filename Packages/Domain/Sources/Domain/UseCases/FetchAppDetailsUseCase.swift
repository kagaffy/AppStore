import Foundation

public final class FetchAppDetailsUseCase {
    private let repository: AppDetailsRepository

    public init(repository: AppDetailsRepository) {
        self.repository = repository
    }

    public func execute(id: String) async throws -> AppDetails? {
        try await repository.fetchAppDetails(id: id)
    }
}
