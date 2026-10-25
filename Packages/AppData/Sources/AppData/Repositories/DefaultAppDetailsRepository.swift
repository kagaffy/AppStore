import Domain
import Foundation
import Hydra

public final class DefaultAppDetailsRepository: AppDetailsRepository {
    public init() {}

    public func fetchAppDetails(id: String, completion: @escaping (Result<AppDetails?, Error>) -> Void) {
        GetAppDetails(id: id).execute(in: .background).then(in: .main) { details in
            completion(.success(details))
        }.catch(in: .main) { error in
            completion(.failure(error))
        }
    }

    public func searchApps(term: String, completion: @escaping (Result<[AppDetails], Error>) -> Void) {
        GetSearchResults(term: term).execute(in: .background).then(in: .main) { results in
            completion(.success(results))
        }.catch(in: .main) { error in
            completion(.failure(error))
        }
    }
}
