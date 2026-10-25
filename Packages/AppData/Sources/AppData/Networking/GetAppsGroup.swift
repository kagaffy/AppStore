import Domain
import Foundation

@available(*, deprecated, message: "Prefer DefaultAppsGroupRepository")
public final class GetAppsGroup: PromiseOperationModel<AppsGroup?> {
    public init(url: URL) {
        super.init()
        self.url = url
        jsonResponse = { data in
            try? JSONDecoder().decode(AppsGroup.self, from: data)
        }
    }
}
