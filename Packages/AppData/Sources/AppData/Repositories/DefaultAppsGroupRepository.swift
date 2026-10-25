import Domain
import Foundation
import Hydra

public final class DefaultAppsGroupRepository: AppsGroupRepository {
    public init() {}

    public func fetchAppsGroup(from url: URL, completion: @escaping (Result<AppsGroup?, Error>) -> Void) {
        GetAppsGroup(url: url).execute(in: .background).then(in: .main) { group in
            completion(.success(group))
        }.catch(in: .main) { error in
            completion(.failure(error))
        }
    }
}
