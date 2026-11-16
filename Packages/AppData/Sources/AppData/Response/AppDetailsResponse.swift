import Domain
import Foundation

/// Lookup / Search API の1件分。
public struct AppDetailsResponse: Decodable, Identifiable, Equatable {
    public let id: Int
    public var artistId: Int
    public var screenshotUrls: [URL]
    public var iconUrl: URL
    public var advisories: [String]?
    public var supportedDevices: [String]
    public var languageCodes: [String]
    public var fileSizeBytes: String
    public var ageLimit: String
    public var releaseDate: String
    public var releaseNotes: String?
    public var primaryGenreId: Int?
    public var sellerName: String
    public var genres: [String]
    public var currentVersionReleaseDateString: String
    public var primaryGenreName: String?
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
        case advisories
        case supportedDevices
        case languageCodes = "languageCodesISO2A"
        case fileSizeBytes
        case ageLimit = "contentAdvisoryRating"
        case releaseDate
        case releaseNotes
        case primaryGenreId
        case sellerName
        case genres
        case currentVersionReleaseDateString = "currentVersionReleaseDate"
        case primaryGenreName
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
        screenshotUrls = try container.decodeIfPresent([URL].self, forKey: .screenshotUrls) ?? []
        iconUrl = try container.decode(URL.self, forKey: .iconUrl)
        advisories = try container.decodeIfPresent([String].self, forKey: .advisories)
        supportedDevices = try container.decodeIfPresent([String].self, forKey: .supportedDevices) ?? []
        languageCodes = try container.decodeIfPresent([String].self, forKey: .languageCodes) ?? []
        fileSizeBytes = try container.decodeIfPresent(String.self, forKey: .fileSizeBytes) ?? "0"
        ageLimit = try container.decodeIfPresent(String.self, forKey: .ageLimit) ?? ""
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
        releaseNotes = try container.decodeIfPresent(String.self, forKey: .releaseNotes)
        primaryGenreId = try container.decodeIfPresent(Int.self, forKey: .primaryGenreId)
        sellerName = try container.decodeIfPresent(String.self, forKey: .sellerName) ?? ""
        genres = try container.decodeIfPresent([String].self, forKey: .genres) ?? []
        currentVersionReleaseDateString = try container.decodeIfPresent(String.self, forKey: .currentVersionReleaseDateString) ?? ""
        primaryGenreName = try container.decodeIfPresent(String.self, forKey: .primaryGenreName)
        price = try container.decodeIfPresent(String.self, forKey: .price) ?? ""
        version = try container.decodeIfPresent(String.self, forKey: .version) ?? ""
        trackName = try container.decode(String.self, forKey: .trackName)
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        averageUserRating = try container.decodeIfPresent(Float.self, forKey: .averageUserRating) ?? 0
        userRatingCount = try container.decodeIfPresent(Int.self, forKey: .userRatingCount) ?? 0
    }

    public func toDomain() -> AppDetails {
        AppDetails(
            id: id,
            artistId: artistId,
            screenshotUrls: screenshotUrls.map(\.absoluteString),
            iconUrl: iconUrl.absoluteString,
            advisories: advisories ?? [],
            supportedDevices: supportedDevices,
            languageCodes: languageCodes,
            fileSizeBytes: fileSizeBytes,
            ageLimit: ageLimit,
            releaseDate: releaseDate,
            releaseNotes: releaseNotes,
            primaryGenreId: primaryGenreId ?? 0,
            sellerName: sellerName,
            genres: genres,
            currentVersionReleaseDateString: currentVersionReleaseDateString,
            primaryGenreName: primaryGenreName ?? "",
            price: price,
            version: version,
            trackName: trackName,
            description: description,
            averageUserRating: averageUserRating,
            userRatingCount: userRatingCount
        )
    }
}

struct LookupResponse: Decodable {
    let results: [AppDetailsResponse]
}
