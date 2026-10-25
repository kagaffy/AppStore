import Foundation

public protocol AppDetailsRepository: AnyObject {
    func fetchAppDetails(id: String, completion: @escaping (Result<AppDetails?, Error>) -> Void)
    func searchApps(term: String, completion: @escaping (Result<[AppDetails], Error>) -> Void)
}
