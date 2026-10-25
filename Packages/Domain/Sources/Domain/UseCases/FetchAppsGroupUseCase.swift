import Foundation

public final class FetchAppsGroupUseCase {
    private let repository: AppsGroupRepository

    public init(repository: AppsGroupRepository) {
        self.repository = repository
    }

    public func execute(url: URL, completion: @escaping (Result<AppsGroup?, Error>) -> Void) {
        repository.fetchAppsGroup(from: url, completion: completion)
    }
}
