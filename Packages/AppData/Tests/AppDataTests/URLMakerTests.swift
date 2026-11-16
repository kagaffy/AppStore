@testable import AppData
import Domain
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

    func testRankingURLUsesLegacyITunesRSS() {
        let url = URLMaker.rankingURL(for: .topFree)
        XCTAssertTrue(url.absoluteString.contains("itunes.apple.com/jp/rss/"))
        XCTAssertTrue(url.absoluteString.contains("topfreeapplications"))
    }

    func testReviewURLIsHTTPS() {
        let url = URLMaker.review(id: "443904275")
        XCTAssertTrue(url.absoluteString.hasPrefix("https://"))
    }
}
