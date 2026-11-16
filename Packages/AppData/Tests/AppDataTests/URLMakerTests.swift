@testable import AppData
import Domain
import Testing

@Test
func detailURLContainsAppID() {
    let url = URLMaker.detail(id: "443904275")
    #expect(url.absoluteString.contains("id=443904275"))
    #expect(url.absoluteString.contains("lookup"))
}

@Test
func searchURLEncodesTerm() {
    let url = URLMaker.search(term: "LINE")
    #expect(url.absoluteString.contains("term=LINE"))
    #expect(url.absoluteString.contains("search"))
}

@Test
func rankingURLUsesLegacyITunesRSS() {
    let url = URLMaker.rankingURL(for: .topFree)
    #expect(url.absoluteString.contains("itunes.apple.com/jp/rss/"))
    #expect(url.absoluteString.contains("topfreeapplications"))
}

@Test
func reviewURLIsHTTPS() {
    let url = URLMaker.review(id: "443904275")
    #expect(url.absoluteString.hasPrefix("https://"))
}
