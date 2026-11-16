import Domain
import Foundation

public final class DefaultAppDetailsRepository: AppDetailsRepository {
    private let client: HTTPClient
    private let decoder: JSONDecoder

    public init(client: HTTPClient = URLSessionHTTPClient(), decoder: JSONDecoder = JSONDecoder()) {
        self.client = client
        self.decoder = decoder
    }

    public func fetchAppDetails(id: String) async throws -> AppDetails? {
        let data = try await client.data(from: URLMaker.detail(id: id))
        let response = try decoder.decode(LookupResponse.self, from: data)
        return response.results.first?.toDomain()
    }

    public func searchApps(term: String) async throws -> [AppDetails] {
        let data = try await client.data(from: URLMaker.search(term: term))
        let response = try decoder.decode(LookupResponse.self, from: data)
        return response.results.map { $0.toDomain() }
    }
}
