import Domain
import XCTest

final class RankingChartTests: XCTestCase {
    func testDisplayTitlesAreClientFixed() {
        XCTAssertEqual(RankingChart.topFree.displayTitle, "トップ無料App")
        XCTAssertEqual(RankingChart.recommendedNewApps.displayTitle, "新着アプリ")
        XCTAssertEqual(RankingChart.topFreeGames.displayTitle, "トップ無料ゲーム")
    }
}
