import Domain
import XCTest

final class AppDetailsTests: XCTestCase {
    func testCurrentVersionReleaseDateDisplay() {
        let details = AppDetails(
            id: 1,
            artistId: 2,
            screenshotUrls: [],
            iconUrl: "https://example.com/icon.png",
            advisories: [],
            supportedDevices: [],
            languageCodes: [],
            fileSizeBytes: "1",
            ageLimit: "4+",
            releaseDate: "2009-10-09T19:50:00Z",
            releaseNotes: nil,
            primaryGenreId: 1,
            sellerName: "Seller",
            genres: [],
            currentVersionReleaseDateString: "2021-02-19T01:11:14Z",
            primaryGenreName: "Games",
            price: "無料",
            version: "1.0",
            trackName: "Demo",
            description: "desc",
            averageUserRating: 4.5,
            userRatingCount: 10
        )

        XCTAssertEqual(details.currentVersionReleaseDateDisplay, "2021-02-19")
        XCTAssertNotNil(details.currentVersionReleaseDate)
    }
}
