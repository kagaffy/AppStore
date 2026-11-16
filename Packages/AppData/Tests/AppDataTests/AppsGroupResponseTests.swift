@testable import AppData
import Foundation
import Testing

@Test
func decodeRankingFixture() throws {
    let data = try fixture("ranking_topfree")
    let response = try JSONDecoder().decode(AppsGroupResponse.self, from: data)
    let group = response.toDomain(title: "トップ無料App")

    #expect(group.title == "トップ無料App")
    #expect(!group.apps.isEmpty)
    #expect(!group.apps[0].id.isEmpty)
    #expect(!group.apps[0].name.isEmpty)
    #expect(!group.apps[0].artistName.isEmpty)
}
