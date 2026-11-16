import Foundation

public protocol AppDetailsRepository: AnyObject {
    func fetchAppDetails(id: String) async throws -> AppDetails?
    func searchApps(term: String) async throws -> [AppDetails]
}
