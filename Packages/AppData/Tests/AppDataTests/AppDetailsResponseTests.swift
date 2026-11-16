import AppData
import XCTest

final class AppDetailsResponseTests: XCTestCase {
    func testDecodeValidJSON() throws {
        let response = try JSONDecoder().decode(AppDetailsResponse.self, from: validJSON)
        XCTAssertEqual(response.id, 333_903_271)
        XCTAssertEqual(response.artistId, 296_415_947)
        XCTAssertEqual(response.screenshotUrls.count, 1)
        XCTAssertEqual(response.iconUrl.absoluteString, "https://example.com/icon.png")
        XCTAssertEqual(response.fileSizeBytes, "133510144")
        XCTAssertEqual(response.ageLimit, "17+")
        XCTAssertEqual(response.releaseNotes, "notes")
        XCTAssertEqual(response.sellerName, "Twitter, Inc.")
        XCTAssertEqual(response.currentVersionReleaseDateString, "2021-02-19T01:11:14Z")
        XCTAssertEqual(response.price, "無料")
        XCTAssertEqual(response.version, "8.54")
        XCTAssertEqual(response.trackName, "Twitter")
        XCTAssertEqual(response.description, "hogehoge")
        XCTAssertEqual(response.averageUserRating, 4.39182)
        XCTAssertEqual(response.userRatingCount, 1_823_139)

        let domain = response.toDomain()
        XCTAssertEqual(domain.id, response.id)
        XCTAssertEqual(domain.trackName, response.trackName)
    }

    func testDecodeInvalidJSONThrows() {
        XCTAssertThrowsError(try JSONDecoder().decode(AppDetailsResponse.self, from: Data()))
    }
}

private let validJSON = """
{
  "screenshotUrls": ["https://example.com/ss.png"],
  "artworkUrl100": "https://example.com/icon.png",
  "supportedDevices": ["iPhone12"],
  "languageCodesISO2A": ["JA"],
  "fileSizeBytes": "133510144",
  "contentAdvisoryRating": "17+",
  "releaseDate": "2009-10-09T19:50:00Z",
  "trackId": 333903271,
  "trackName": "Twitter",
  "formattedPrice": "無料",
  "sellerName": "Twitter, Inc.",
  "currentVersionReleaseDate": "2021-02-19T01:11:14Z",
  "releaseNotes": "notes",
  "genres": ["ニュース"],
  "version": "8.54",
  "artistId": 296415947,
  "description": "hogehoge",
  "averageUserRating": 4.39182,
  "userRatingCount": 1823139
}
""".data(using: .utf8)!
