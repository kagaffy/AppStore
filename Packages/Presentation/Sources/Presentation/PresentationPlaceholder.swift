import Domain
import Foundation

/// Phase 1 skeleton. ViewModels / SwiftUI screens land in Phase 3.
public enum PresentationModule {
    public static let name = "Presentation"

    /// Ensures the Presentation → Domain dependency stays linked.
    public static func domainTypesAvailable() -> [String] {
        [String(describing: AppsGroup.self), String(describing: AppDetails.self), String(describing: Review.self)]
    }
}
