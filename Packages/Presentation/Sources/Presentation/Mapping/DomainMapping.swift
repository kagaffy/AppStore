import Domain
import Foundation

public extension AppModel {
    init(entity: App) {
        self.init(
            id: entity.id,
            name: entity.name,
            artistName: entity.artistName,
            iconUrl: entity.iconUrl
        )
    }
}

public extension AppsGroupModel {
    init(entity: AppsGroup) {
        self.init(
            title: entity.title,
            apps: entity.apps.map(AppModel.init(entity:))
        )
    }
}

public extension AppsSearchResultModel {
    init(entity: AppDetails) {
        self.init(
            id: entity.id,
            trackName: entity.trackName,
            iconUrl: entity.iconUrl,
            screenshotUrls: entity.screenshotUrls,
            price: entity.price,
            userRatingCount: entity.userRatingCount
        )
    }
}

public extension AppDetailsModel {
    init(entity: AppDetails) {
        self.init(
            id: entity.id,
            artistId: entity.artistId,
            screenshotUrls: entity.screenshotUrls,
            iconUrl: entity.iconUrl,
            advisories: entity.advisories,
            supportedDevices: entity.supportedDevices,
            languageCodes: entity.languageCodes,
            fileSizeBytes: entity.fileSizeBytes,
            ageLimit: entity.ageLimit,
            releaseDate: entity.releaseDate,
            releaseNotes: entity.releaseNotes,
            primaryGenreId: entity.primaryGenreId,
            sellerName: entity.sellerName,
            genres: entity.genres,
            currentVersionReleaseDateString: entity.currentVersionReleaseDateString,
            currentVersionReleaseDateDisplay: entity.currentVersionReleaseDateDisplay,
            primaryGenreName: entity.primaryGenreName,
            price: entity.price,
            version: entity.version,
            trackName: entity.trackName,
            description: entity.description,
            averageUserRating: entity.averageUserRating,
            userRatingCount: entity.userRatingCount
        )
    }
}

public extension ReviewModel {
    init(entity: Review) {
        self.init(
            id: entity.id,
            name: entity.name,
            rating: entity.rating,
            title: entity.title,
            content: entity.content
        )
    }
}
