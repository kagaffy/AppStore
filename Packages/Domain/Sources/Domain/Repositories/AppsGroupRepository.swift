import Foundation

public protocol AppsGroupRepository: AnyObject {
    func fetchAppsGroup(from url: URL, completion: @escaping (Result<AppsGroup?, Error>) -> Void)
}
