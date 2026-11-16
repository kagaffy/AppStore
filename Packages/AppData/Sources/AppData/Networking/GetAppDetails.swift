import Domain
import Foundation

@available(*, deprecated, message: "Prefer DefaultAppDetailsRepository")
public final class GetAppDetails: PromiseOperation<AppDetails?> {
    public init(id: String) {
        super.init()
        url = URLMaker.detail(id: id)
        jsonResponse = { json in
            AppDetailsResponse.make(from: json["results"].array?.first)
        }
    }
}

@available(*, deprecated, message: "Prefer DefaultAppDetailsRepository")
public final class GetSearchResults: PromiseOperation<[AppDetails]> {
    public init(term: String) {
        super.init()
        url = URLMaker.search(term: term)
        jsonResponse = { json in
            AppDetailsResponse.load(json["results"].arrayValue)
        }
    }
}
