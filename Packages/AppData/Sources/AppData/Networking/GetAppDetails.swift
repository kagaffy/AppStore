import Domain
import Foundation

@available(*, deprecated, message: "Prefer DefaultAppDetailsRepository")
public final class GetAppDetails: PromiseOperation<AppDetails?> {
    public init(id: String) {
        super.init()
        url = URLMaker.detail(id: id)
        jsonResponse = { json in
            AppDetailsDTO.make(from: json["results"].array?.first)
        }
    }
}

@available(*, deprecated, message: "Prefer DefaultAppDetailsRepository")
public final class GetSearchResults: PromiseOperation<[AppDetails]> {
    public init(term: String) {
        super.init()
        url = URLMaker.search(term: term)
        jsonResponse = { json in
            AppDetailsDTO.load(json["results"].arrayValue)
        }
    }
}
