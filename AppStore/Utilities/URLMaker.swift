//
//  URLMaker.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/08/20.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import Foundation

// http://www.ianbauters.be/genreid/documentation/itunes_search_api_jp/index.html

class URLMaker {
    static let searchBase = "https://itunes.apple.com/search?"
    static let rssBase = "https://rss.itunes.apple.com/api/v1/jp/ios-apps/"

    static var recommendedNewApps: URL {
        URL(string: "\(rssBase)new-apps-we-love/all/15/explicit.json")!
    }

    static var recommendedNewGames: URL {
        URL(string: "\(rssBase)new-games-we-love/all/15/explicit.json")!
    }

    static var topFree: URL {
        URL(string: "\(rssBase)top-free/all/15/explicit.json")!
    }

    static var topFreeGames: URL {
        URL(string: "\(rssBase)top-free/games/15/explicit.json")!
    }

    static var ipadTopFree: URL {
        URL(string: "\(rssBase)top-free-ipad/all/15/explicit.json")!
    }

    static var topSales: URL {
        URL(string: "\(rssBase)top-grossing/all/15/explicit.json")!
    }

    static var ipadTopSales: URL {
        URL(string: "\(rssBase)top-grossing-ipad/all/15/explicit.json")!
    }

    static var topPaid: URL {
        URL(string: "\(rssBase)top-paid/all/15/explicit.json")!
    }

    static var topPaidGames: URL {
        URL(string: "\(rssBase)top-paid/games/15/explicit.json")!
    }

    static func search(term: String) -> URL {
        URL(string: "\(searchBase)term=\(term.urlEncoded)&country=jp&media=software&entity=software&lang=ja_jp")!
    }

    static func detail(id: String) -> URL {
        URL(string: "https://itunes.apple.com/lookup?id=\(id)&country=jp&media=software&entity=software&lang=ja_jp")!
    }

    static func review(id: String) -> URL {
        URL(string: "http://itunes.apple.com/jp/rss/customerreviews/id=\(id)/json")!
    }
}
