import Foundation

public protocol AppsGroupRepository: AnyObject {
    func fetchRanking(chart: RankingChart) async throws -> AppsGroup
}
