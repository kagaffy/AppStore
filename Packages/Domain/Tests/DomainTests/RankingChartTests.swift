import Domain
import Testing

@Test
func rankingChartDisplayTitlesAreClientFixed() {
    #expect(RankingChart.topFree.displayTitle == "トップ無料App")
    #expect(RankingChart.recommendedNewApps.displayTitle == "新着アプリ")
    #expect(RankingChart.topFreeGames.displayTitle == "トップ無料ゲーム")
}
