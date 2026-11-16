import Combine
import Domain
import Foundation

@MainActor
public final class AppsSearchViewModel: ObservableObject {
    @Published public private(set) var results: [AppsSearchResultModel] = []
    @Published public private(set) var isLoading = false

    private let searchApps: SearchAppsUseCase
    private var searchTask: Task<Void, Never>?

    public init(searchApps: SearchAppsUseCase) {
        self.searchApps = searchApps
    }

    public func searchTextDidChange(_ text: String) {
        searchTask?.cancel()
        results = []

        let term = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !term.isEmpty else {
            isLoading = false
            return
        }

        searchTask = Task { [weak self] in
            try? await Task.sleep(nanoseconds: 300_000_000)
            guard !Task.isCancelled else { return }
            await self?.performSearch(term: term)
        }
    }

    public func clearResults() {
        searchTask?.cancel()
        results = []
        isLoading = false
    }

    private func performSearch(term: String) async {
        isLoading = true
        defer { isLoading = false }

        do {
            let apps = try await searchApps.execute(term: term)
            guard !Task.isCancelled else { return }
            results = apps.map(AppsSearchResultModel.init(entity:))
        } catch {
            guard !Task.isCancelled else { return }
            results = []
        }
    }
}
