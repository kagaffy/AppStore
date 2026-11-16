import Foundation

public final class FetchAppDetailsUseCase {
    private let repository: AppDetailsRepository

    public init(repository: AppDetailsRepository) {
        self.repository = repository
    }

    public func execute(id: String, completion: @escaping (Result<AppDetails?, Error>) -> Void) {
        repository.fetchAppDetails(id: id, completion: completion)
    }
}
