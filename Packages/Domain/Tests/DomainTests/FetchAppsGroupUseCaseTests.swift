import Domain
import XCTest

final class FetchAppsGroupUseCaseTests: XCTestCase {
    func testExecuteReturnsRepositoryResult() {
        let expected = AppsGroup(
            title: "Top Free",
            apps: [
                App(
                    id: "1",
                    name: "Demo",
                    artistName: "Artist",
                    iconUrl: URL(string: "https://example.com/icon.png")!
                ),
            ]
        )
        let repository = MockAppsGroupRepository(result: .success(expected))
        let useCase = FetchAppsGroupUseCase(repository: repository)
        let expectation = expectation(description: "fetch")

        useCase.execute(url: URL(string: "https://example.com")!) { result in
            switch result {
            case let .success(group):
                XCTAssertEqual(group, expected)
            case let .failure(error):
                XCTFail("Unexpected error: \(error)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(repository.requestedURLs.count, 1)
    }
}

private final class MockAppsGroupRepository: AppsGroupRepository {
    private let result: Result<AppsGroup?, Error>
    private(set) var requestedURLs: [URL] = []

    init(result: Result<AppsGroup?, Error>) {
        self.result = result
    }

    func fetchAppsGroup(from url: URL, completion: @escaping (Result<AppsGroup?, Error>) -> Void) {
        requestedURLs.append(url)
        completion(result)
    }
}
