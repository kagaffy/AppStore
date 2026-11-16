import Domain
import Foundation
import Presentation
import Testing

@MainActor
@Test
func appsSearchViewModelMapsSuccessfulResults() async throws {
    let details = makeAppDetails(id: 1, trackName: "LINE")
    let repository = MockAppDetailsRepository(searchResult: [details])
    let viewModel = AppsSearchViewModel(
        searchApps: SearchAppsUseCase(repository: repository)
    )

    viewModel.searchTextDidChange("LINE")
    try await waitUntil { !viewModel.results.isEmpty }

    #expect(viewModel.results.count == 1)
    #expect(viewModel.results[0].id == 1)
    #expect(viewModel.results[0].trackName == "LINE")
    #expect(repository.searchTerms == ["LINE"])
}

@MainActor
@Test
func appsSearchViewModelClearsOnEmptyQuery() {
    let repository = MockAppDetailsRepository(searchResult: [makeAppDetails(id: 1, trackName: "LINE")])
    let viewModel = AppsSearchViewModel(
        searchApps: SearchAppsUseCase(repository: repository)
    )

    viewModel.searchTextDidChange("LINE")
    viewModel.searchTextDidChange("")

    #expect(viewModel.results.isEmpty)
    #expect(viewModel.isLoading == false)
}

@MainActor
@Test
func appsSearchViewModelClearResultsResetsState() async throws {
    let repository = MockAppDetailsRepository(searchResult: [makeAppDetails(id: 1, trackName: "LINE")])
    let viewModel = AppsSearchViewModel(
        searchApps: SearchAppsUseCase(repository: repository)
    )

    viewModel.searchTextDidChange("LINE")
    try await waitUntil { !viewModel.results.isEmpty }
    viewModel.clearResults()

    #expect(viewModel.results.isEmpty)
    #expect(viewModel.isLoading == false)
}
