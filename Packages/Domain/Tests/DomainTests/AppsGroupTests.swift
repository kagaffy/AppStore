import Domain
import Foundation
import Testing

@Test
func appsGroupInitStoresTitleAndApps() throws {
    let app = try App(
        id: "1",
        name: "Demo",
        artistName: "Artist",
        iconUrl: #require(URL(string: "https://example.com/icon.png"))
    )
    let group = AppsGroup(title: "トップ無料App", apps: [app])
    #expect(group.title == "トップ無料App")
    #expect(group.apps == [app])
}
