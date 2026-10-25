import Foundation

public final class SearchAppsUseCase {
    private let repository: AppDetailsRepository

    public init(repository: AppDetailsRepository) {
        self.repository = repository
    }

    public func execute(term: String, completion: @escaping (Result<[AppDetails], Error>) -> Void) {
        repository.searchApps(term: term, completion: completion)
    }
}
