//
//  AppDetails.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/12/26.
//

import Foundation
import SwiftDate
import SwiftyJSON

@available(*, deprecated)
public struct AppDetails {
    public let id: Int
    public let artistId: Int
    public var screenshotUrls: [String]
    public var iconUrl: String
    public var advisories: [String]
    public var supportedDevices: [String]
    public var languageCodes: [String]
    public var fileSizeBytes: String
    public var ageLimit: String
    public var releaseDate: String
    public var releaseNotes: String?
    public var primaryGenreId: Int
    public var sellerName: String
    public var genres: [String]
    public var currentVersionReleaseDateString: String
    public var currentVersionReleaseDate: DateInRegion? {
        DateInRegion(currentVersionReleaseDateString)
    }

    public var primaryGenreName: String
    public var price: String
    public var version: String
    public var trackName: String
    public var description: String
    public var averageUserRating: Float
    public var userRatingCount: Int

    public init?(_ json: JSON?) {
        guard let json else { return nil }

        guard let id = json["trackId"].int else { return nil }
        guard let artistId = json["artistId"].int else { return nil }
        guard let screenshotUrls = json["screenshotUrls"].array else { return nil }
        guard let iconUrl = json["artworkUrl100"].string else { return nil }
        guard let advisories = json["advisories"].array else { return nil }
        guard let supportedDevices = json["supportedDevices"].array else { return nil }
        guard let languageCodes = json["languageCodesISO2A"].array else { return nil }
        guard let fileSizeBytes = json["fileSizeBytes"].string else { return nil }
        guard let ageLimit = json["contentAdvisoryRating"].string else { return nil }
        guard let releaseDate = json["releaseDate"].string else { return nil }
        guard let primaryGenreId = json["primaryGenreId"].int else { return nil }
        guard let sellerName = json["sellerName"].string else { return nil }
        guard let genres = json["genres"].array else { return nil }
        guard let currentVersionReleaseDateString = json["currentVersionReleaseDate"].string else { return nil }
        guard let primaryGenreName = json["primaryGenreName"].string else { return nil }
        guard let price = json["formattedPrice"].string else { return nil }
        guard let version = json["version"].string else { return nil }
        guard let trackName = json["trackName"].string else { return nil }
        guard let description = json["description"].string else { return nil }
        guard let averageUserRating = json["averageUserRating"].float else { return nil }
        guard let userRatingCount = json["userRatingCount"].int else { return nil }

        self.id = id
        self.artistId = artistId
        self.screenshotUrls = screenshotUrls.compactMap(\.string)
        self.iconUrl = iconUrl
        self.advisories = advisories.compactMap(\.string)
        self.supportedDevices = supportedDevices.compactMap(\.string)
        self.languageCodes = languageCodes.compactMap(\.string)
        self.fileSizeBytes = fileSizeBytes
        self.ageLimit = ageLimit
        self.releaseDate = releaseDate
        releaseNotes = json["releaseNotes"].string
        self.primaryGenreId = primaryGenreId
        self.sellerName = sellerName
        self.genres = genres.compactMap(\.string)
        self.currentVersionReleaseDateString = currentVersionReleaseDateString
        self.primaryGenreName = primaryGenreName
        self.price = price
        self.version = version
        self.trackName = trackName
        self.description = description
        self.averageUserRating = averageUserRating
        self.userRatingCount = userRatingCount
    }

    static func load(_ array: [JSON]) -> [AppDetails] {
        array.compactMap { AppDetails($0) }
    }
}

public class GetAppDetails: PromiseOperation<AppDetails?> {
    public init(id: String) {
        super.init()

        url = URLMaker.detail(id: id)

        jsonResponse = { json in
            AppDetails(json["results"].array?.first)
        }
    }
}

public class GetSearchResults: PromiseOperation<[AppDetails]> {
    public init(term: String) {
        super.init()

        url = URLMaker.search(term: term)

        jsonResponse = { json in
            AppDetails.load(json["results"].arrayValue)
        }
    }
}

struct AppDetailsModel: Decodable, Identifiable {
    let id: Int
    var artistId: Int
    var screenshotUrls: [URL]
    var iconUrl: URL
    var supportedDevices: [String]
    var languageCodes: [String]
    var fileSizeBytes: String
    var ageLimit: String
    var releaseDate: String
    var releaseNotes: String?
    var sellerName: String
    var genres: [String]
    var currentVersionReleaseDateString: String
    var currentVersionReleaseDate: DateInRegion? {
        DateInRegion(currentVersionReleaseDateString)
    }

    var price: String
    var version: String
    var trackName: String
    var description: String
    var averageUserRating: Float
    var userRatingCount: Int

    private enum Key: String, CodingKey {
        case id = "trackId"
        case artistId
        case screenshotUrls
        case iconUrl = "artworkUrl100"
        case supportedDevices
        case languageCodes = "languageCodesISO2A"
        case fileSizeBytes
        case ageLimit = "contentAdvisoryRating"
        case releaseDate
        case releaseNotes
        case sellerName
        case genres
        case currentVersionReleaseDateString = "currentVersionReleaseDate"
        case price = "formattedPrice"
        case version
        case trackName
        case description
        case averageUserRating
        case userRatingCount
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        id = try container.decode(Int.self, forKey: .id)
        artistId = try container.decode(Int.self, forKey: .artistId)
        screenshotUrls = try container.decode([URL].self, forKey: .screenshotUrls)
        iconUrl = try container.decode(URL.self, forKey: .iconUrl)
        supportedDevices = try container.decode([String].self, forKey: .supportedDevices)
        languageCodes = try container.decode([String].self, forKey: .languageCodes)
        fileSizeBytes = try container.decode(String.self, forKey: .fileSizeBytes)
        ageLimit = try container.decode(String.self, forKey: .ageLimit)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        releaseNotes = try container.decodeIfPresent(String.self, forKey: .releaseNotes)
        sellerName = try container.decode(String.self, forKey: .sellerName)
        genres = try container.decode([String].self, forKey: .genres)
        currentVersionReleaseDateString = try container.decode(String.self, forKey: .currentVersionReleaseDateString)
        price = try container.decode(String.self, forKey: .price)
        version = try container.decode(String.self, forKey: .version)
        trackName = try container.decode(String.self, forKey: .trackName)
        description = try container.decode(String.self, forKey: .description)
        averageUserRating = try container.decode(Float.self, forKey: .averageUserRating)
        userRatingCount = try container.decode(Int.self, forKey: .userRatingCount)
    }
}
