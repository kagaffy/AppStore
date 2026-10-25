//
//  AppsGroup.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/12/27.
//

import Foundation

struct AppsGroup: Decodable {
    // MARK: public
    var title: String {
        feed.title
    }

    var apps: [App] {
        feed.results
    }

    // MARK: internal
    private let feed: Feed
    private struct Feed: Decodable {
        let title: String
        let results: [App]
    }
}

struct App: Decodable, Identifiable {
    let id: String
    var name: String
    var artistName: String
    var iconUrl: URL

    private enum Key: String, CodingKey {
        case id
        case name
        case artistName
        case iconUrl = "artworkUrl100"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        artistName = try container.decode(String.self, forKey: .artistName)
        iconUrl = try container.decode(URL.self, forKey: .iconUrl)
    }
}

@available(*, deprecated)
class GetAppsGroup: PromiseOperationModel<AppsGroup?> {
    init(url: URL) {
        super.init()

        self.url = url

        jsonResponse = { json in
            try? JSONDecoder().decode(AppsGroup.self, from: json)
        }
    }
}
