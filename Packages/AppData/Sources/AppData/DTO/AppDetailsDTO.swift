import Domain
import Foundation
import SwiftyJSON

enum AppDetailsDTO {
    static func make(from json: JSON?) -> AppDetails? {
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

        return AppDetails(
            id: id,
            artistId: artistId,
            screenshotUrls: screenshotUrls.compactMap(\.string),
            iconUrl: iconUrl,
            advisories: advisories.compactMap(\.string),
            supportedDevices: supportedDevices.compactMap(\.string),
            languageCodes: languageCodes.compactMap(\.string),
            fileSizeBytes: fileSizeBytes,
            ageLimit: ageLimit,
            releaseDate: releaseDate,
            releaseNotes: json["releaseNotes"].string,
            primaryGenreId: primaryGenreId,
            sellerName: sellerName,
            genres: genres.compactMap(\.string),
            currentVersionReleaseDateString: currentVersionReleaseDateString,
            primaryGenreName: primaryGenreName,
            price: price,
            version: version,
            trackName: trackName,
            description: description,
            averageUserRating: averageUserRating,
            userRatingCount: userRatingCount
        )
    }

    static func load(_ array: [JSON]) -> [AppDetails] {
        array.compactMap { make(from: $0) }
    }
}

/// Codable DTO used by DomainTests / DataTests (lookup result item shape).
public struct AppDetailsModel: Decodable, Identifiable, Equatable {
    public let id: Int
    public var artistId: Int
    public var screenshotUrls: [URL]
    public var iconUrl: URL
    public var supportedDevices: [String]
    public var languageCodes: [String]
    public var fileSizeBytes: String
    public var ageLimit: String
    public var releaseDate: String
    public var releaseNotes: String?
    public var sellerName: String
    public var genres: [String]
    public var currentVersionReleaseDateString: String
    public var price: String
    public var version: String
    public var trackName: String
    public var description: String
    public var averageUserRating: Float
    public var userRatingCount: Int

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

    public init(from decoder: Decoder) throws {
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

    public func toDomain() -> AppDetails {
        AppDetails(
            id: id,
            artistId: artistId,
            screenshotUrls: screenshotUrls.map(\.absoluteString),
            iconUrl: iconUrl.absoluteString,
            advisories: [],
            supportedDevices: supportedDevices,
            languageCodes: languageCodes,
            fileSizeBytes: fileSizeBytes,
            ageLimit: ageLimit,
            releaseDate: releaseDate,
            releaseNotes: releaseNotes,
            primaryGenreId: 0,
            sellerName: sellerName,
            genres: genres,
            currentVersionReleaseDateString: currentVersionReleaseDateString,
            primaryGenreName: "",
            price: price,
            version: version,
            trackName: trackName,
            description: description,
            averageUserRating: averageUserRating,
            userRatingCount: userRatingCount
        )
    }
}
