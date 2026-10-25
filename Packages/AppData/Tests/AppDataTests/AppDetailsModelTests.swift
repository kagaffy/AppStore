import AppData
import XCTest

final class AppDetailsModelTests: XCTestCase {
    func testDecodeValidJSON() throws {
        let appDetails = try JSONDecoder().decode(AppDetailsModel.self, from: validJSON)
        XCTAssertEqual(appDetails.id, 333_903_271)
        XCTAssertEqual(appDetails.artistId, 296_415_947)
        XCTAssertEqual(appDetails.screenshotUrls.count, 1)
        XCTAssertEqual(appDetails.iconUrl.absoluteString, "https://example.com/icon.png")
        XCTAssertEqual(appDetails.fileSizeBytes, "133510144")
        XCTAssertEqual(appDetails.ageLimit, "17+")
        XCTAssertEqual(appDetails.releaseNotes, "notes")
        XCTAssertEqual(appDetails.sellerName, "Twitter, Inc.")
        XCTAssertEqual(appDetails.currentVersionReleaseDateString, "2021-02-19T01:11:14Z")
        XCTAssertEqual(appDetails.price, "無料")
        XCTAssertEqual(appDetails.version, "8.54")
        XCTAssertEqual(appDetails.trackName, "Twitter")
        XCTAssertEqual(appDetails.description, "hogehoge")
        XCTAssertEqual(appDetails.averageUserRating, 4.39182)
        XCTAssertEqual(appDetails.userRatingCount, 1_823_139)

        let domain = appDetails.toDomain()
        XCTAssertEqual(domain.id, appDetails.id)
        XCTAssertEqual(domain.trackName, appDetails.trackName)
    }

    func testDecodeInvalidJSONThrows() {
        XCTAssertThrowsError(try JSONDecoder().decode(AppDetailsModel.self, from: Data()))
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
