@testable import AppData
import Foundation
import Testing

@Test
func decodeLookupFixture() throws {
    let data = try fixture("lookup_line")
    let response = try JSONDecoder().decode(LookupResponse.self, from: data)
    let details = try #require(response.results.first?.toDomain())

    #expect(details.id == 443_904_275)
    #expect(!details.trackName.isEmpty)
    #expect(!details.iconUrl.isEmpty)
}
