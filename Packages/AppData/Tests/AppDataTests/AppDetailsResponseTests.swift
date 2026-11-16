@testable import AppData
import XCTest

final class AppDetailsResponseTests: XCTestCase {
    func testDecodeLookupFixture() throws {
        let data = try fixture("lookup_line")
        let response = try JSONDecoder().decode(LookupResponse.self, from: data)
        let details = try XCTUnwrap(response.results.first?.toDomain())

        XCTAssertEqual(details.id, 443_904_275)
        XCTAssertFalse(details.trackName.isEmpty)
        XCTAssertFalse(details.iconUrl.isEmpty)
    }
}
