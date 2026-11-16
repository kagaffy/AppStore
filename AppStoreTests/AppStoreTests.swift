@testable import AppStore
import Testing

/// Host-app unit tests are skipped in CI; package tests are the primary suite.
@Test
func appStoreHostTargetLoads() {
    #expect(true)
}
