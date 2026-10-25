import Foundation

public enum URLMaker {
    public static let searchBase = "https://itunes.apple.com/search?"
    public static let rssBase = "https://rss.itunes.apple.com/api/v1/jp/ios-apps/"

    public static var recommendedNewApps: URL {
        URL(string: "\(rssBase)new-apps-we-love/all/15/explicit.json")!
    }

    public static var recommendedNewGames: URL {
        URL(string: "\(rssBase)new-games-we-love/all/15/explicit.json")!
    }

    public static var topFree: URL {
        URL(string: "\(rssBase)top-free/all/15/explicit.json")!
    }

    public static var topFreeGames: URL {
        URL(string: "\(rssBase)top-free/games/15/explicit.json")!
    }

    public static var ipadTopFree: URL {
        URL(string: "\(rssBase)top-free-ipad/all/15/explicit.json")!
    }

    public static var topSales: URL {
        URL(string: "\(rssBase)top-grossing/all/15/explicit.json")!
    }

    public static var ipadTopSales: URL {
        URL(string: "\(rssBase)top-grossing-ipad/all/15/explicit.json")!
    }

    public static var topPaid: URL {
        URL(string: "\(rssBase)top-paid/all/15/explicit.json")!
    }

    public static var topPaidGames: URL {
        URL(string: "\(rssBase)top-paid/games/15/explicit.json")!
    }

    public static func search(term: String) -> URL {
        URL(string: "\(searchBase)term=\(term.urlEncoded)&country=jp&media=software&entity=software&lang=ja_jp")!
    }

    public static func detail(id: String) -> URL {
        URL(string: "https://itunes.apple.com/lookup?id=\(id)&country=jp&media=software&entity=software&lang=ja_jp")!
    }

    public static func review(id: String) -> URL {
        URL(string: "http://itunes.apple.com/jp/rss/customerreviews/id=\(id)/json")!
    }
}

private extension String {
    var urlEncoded: String {
        let charset = CharacterSet.alphanumerics.union(.init(charactersIn: "/?-._~"))
        let removed = removingPercentEncoding ?? self
        return removed.addingPercentEncoding(withAllowedCharacters: charset) ?? removed
    }
}
