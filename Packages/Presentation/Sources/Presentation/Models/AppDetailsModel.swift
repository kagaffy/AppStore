import Foundation

public struct AppDetailsModel: Equatable, Sendable {
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
    public var currentVersionReleaseDateDisplay: String
    public var primaryGenreName: String
    public var price: String
    public var version: String
    public var trackName: String
    public var description: String
    public var averageUserRating: Float
    public var userRatingCount: Int

    public init(
        id: Int,
        artistId: Int,
        screenshotUrls: [String],
        iconUrl: String,
        advisories: [String],
        supportedDevices: [String],
        languageCodes: [String],
        fileSizeBytes: String,
        ageLimit: String,
        releaseDate: String,
        releaseNotes: String?,
        primaryGenreId: Int,
        sellerName: String,
        genres: [String],
        currentVersionReleaseDateString: String,
        currentVersionReleaseDateDisplay: String,
        primaryGenreName: String,
        price: String,
        version: String,
        trackName: String,
        description: String,
        averageUserRating: Float,
        userRatingCount: Int
    ) {
        self.id = id
        self.artistId = artistId
        self.screenshotUrls = screenshotUrls
        self.iconUrl = iconUrl
        self.advisories = advisories
        self.supportedDevices = supportedDevices
        self.languageCodes = languageCodes
        self.fileSizeBytes = fileSizeBytes
        self.ageLimit = ageLimit
        self.releaseDate = releaseDate
        self.releaseNotes = releaseNotes
        self.primaryGenreId = primaryGenreId
        self.sellerName = sellerName
        self.genres = genres
        self.currentVersionReleaseDateString = currentVersionReleaseDateString
        self.currentVersionReleaseDateDisplay = currentVersionReleaseDateDisplay
        self.primaryGenreName = primaryGenreName
        self.price = price
        self.version = version
        self.trackName = trackName
        self.description = description
        self.averageUserRating = averageUserRating
        self.userRatingCount = userRatingCount
    }
}
