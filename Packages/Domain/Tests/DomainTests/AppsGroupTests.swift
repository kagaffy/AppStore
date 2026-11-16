import Domain
import XCTest

final class AppsGroupTests: XCTestCase {
    func testInitStoresTitleAndApps() {
        let app = App(
            id: "1",
            name: "Demo",
            artistName: "Artist",
            iconUrl: URL(string: "https://example.com/icon.png")!
        )
        let group = AppsGroup(title: "トップ無料App", apps: [app])
        XCTAssertEqual(group.title, "トップ無料App")
        XCTAssertEqual(group.apps, [app])
    }
}
