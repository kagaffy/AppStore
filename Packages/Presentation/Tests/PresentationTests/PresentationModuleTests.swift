import Presentation
import XCTest

final class PresentationModuleTests: XCTestCase {
    func testModuleExposesDomainTypes() {
        XCTAssertFalse(PresentationModule.domainTypesAvailable().isEmpty)
        XCTAssertEqual(PresentationModule.name, "Presentation")
    }
}
