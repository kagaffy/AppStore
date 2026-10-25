import AppData
import XCTest

final class URLMakerTests: XCTestCase {
    func testDetailURLContainsAppID() {
        let url = URLMaker.detail(id: "443904275")
        XCTAssertTrue(url.absoluteString.contains("id=443904275"))
        XCTAssertTrue(url.absoluteString.contains("lookup"))
    }

    func testSearchURLEncodesTerm() {
        let url = URLMaker.search(term: "LINE")
        XCTAssertTrue(url.absoluteString.contains("term=LINE"))
        XCTAssertTrue(url.absoluteString.contains("search"))
    }
}
