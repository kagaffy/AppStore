import Combine
import Domain
import Foundation

@MainActor
public final class IntroductionViewModel: ObservableObject {
    @Published public private(set) var appsGroups: [AppsGroupModel] = []

    private let fetchAppsGroup: FetchAppsGroupUseCase
    private let charts: [RankingChart]
    private var loadTasks: [Task<Void, Never>] = []

    public init(fetchAppsGroup: FetchAppsGroupUseCase, charts: [RankingChart]) {
        self.fetchAppsGroup = fetchAppsGroup
        self.charts = charts
    }

    public func load() {
        loadTasks.forEach { $0.cancel() }
        loadTasks = []
        appsGroups = []

        for chart in charts {
            let task = Task { [weak self] in
                guard let self else { return }
                do {
                    let entity = try await self.fetchAppsGroup.execute(chart: chart)
                    guard !Task.isCancelled else { return }
                    self.appsGroups.append(AppsGroupModel(entity: entity))
                } catch {
                    // Ranking failures stay quiet (legacy API tolerance).
                }
            }
            loadTasks.append(task)
        }
    }
}
