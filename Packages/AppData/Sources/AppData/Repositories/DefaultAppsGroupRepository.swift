import Domain
import Foundation

public final class DefaultAppsGroupRepository: AppsGroupRepository {
    private let client: HTTPClient
    private let decoder: JSONDecoder

    public init(client: HTTPClient = URLSessionHTTPClient(), decoder: JSONDecoder = JSONDecoder()) {
        self.client = client
        self.decoder = decoder
    }

    public func fetchRanking(chart: RankingChart) async throws -> AppsGroup {
        let url = URLMaker.rankingURL(for: chart)
        let data = try await client.data(from: url)
        let response = try decoder.decode(AppsGroupResponse.self, from: data)
        return response.toDomain(title: chart.displayTitle)
    }
}
