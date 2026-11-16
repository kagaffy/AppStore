import Domain
import XCTest

final class AppsGroupTests: XCTestCase {
    func testDecodeValidJSON() throws {
        let appsGroup = try JSONDecoder().decode(AppsGroup.self, from: validJSON)
        XCTAssertEqual(appsGroup.title, "Top Free iPhone Apps")
        XCTAssertEqual(appsGroup.apps.count, 1)

        let app = try XCTUnwrap(appsGroup.apps.first)
        XCTAssertEqual(app.id, "1504185645")
        XCTAssertEqual(app.name, "NieR Re[in]carnation")
        XCTAssertEqual(app.artistName, "SQUARE ENIX")
        XCTAssertEqual(
            app.iconUrl.absoluteString,
            "https://is2-ssl.mzstatic.com/image/thumb/example.png/200x200bb.png"
        )
    }

    func testDecodeInvalidJSONThrows() {
        XCTAssertThrowsError(try JSONDecoder().decode(AppsGroup.self, from: Data()))
    }
}

private let validJSON = """
{
  "feed": {
    "title": "Top Free iPhone Apps",
    "results": [
      {
        "artistName": "SQUARE ENIX",
        "id": "1504185645",
        "name": "NieR Re[in]carnation",
        "artworkUrl100": "https://is2-ssl.mzstatic.com/image/thumb/example.png/200x200bb.png"
      }
    ]
  }
}
""".data(using: .utf8)!
