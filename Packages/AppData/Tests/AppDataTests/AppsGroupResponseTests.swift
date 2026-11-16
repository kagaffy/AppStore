@testable import AppData
import XCTest

final class AppsGroupResponseTests: XCTestCase {
    func testDecodeRankingFixture() throws {
        let data = try fixture("ranking_topfree")
        let response = try JSONDecoder().decode(AppsGroupResponse.self, from: data)
        let group = response.toDomain(title: "トップ無料App")

        XCTAssertEqual(group.title, "トップ無料App")
        XCTAssertFalse(group.apps.isEmpty)
        XCTAssertFalse(group.apps[0].id.isEmpty)
        XCTAssertFalse(group.apps[0].name.isEmpty)
        XCTAssertFalse(group.apps[0].artistName.isEmpty)
    }
}
