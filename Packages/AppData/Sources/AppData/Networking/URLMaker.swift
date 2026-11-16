import Domain
import Foundation

public enum URLMaker {
    private static let searchBase = "https://itunes.apple.com/search?"
    private static let rssBase = "https://itunes.apple.com/jp/rss/"

    public static func rankingURL(for chart: RankingChart) -> URL {
        switch chart {
        case .recommendedNewApps, .recommendedNewGames:
            // We Love 相当 API は無いため新着一覧で代用
            return url("newapplications/limit=15/json")
        case .topFree:
            return url("topfreeapplications/limit=15/json")
        case .ipadTopFree:
            return url("topfreeipadapplications/limit=15/json")
        case .topSales:
            return url("topgrossingapplications/limit=15/json")
        case .ipadTopSales:
            return url("topgrossingipadapplications/limit=15/json")
        case .topPaid:
            return url("toppaidapplications/limit=15/json")
        case .topFreeGames:
            return url("topfreeapplications/limit=15/genre=6014/json")
        case .topPaidGames:
            return url("toppaidapplications/limit=15/genre=6014/json")
        }
    }

    public static func search(term: String) -> URL {
        URL(string: "\(searchBase)term=\(term.urlEncoded)&country=jp&media=software&entity=software&lang=ja_jp")!
    }

    public static func detail(id: String) -> URL {
        URL(string: "https://itunes.apple.com/lookup?id=\(id)&country=jp&media=software&entity=software&lang=ja_jp")!
    }

    public static func review(id: String) -> URL {
        URL(string: "https://itunes.apple.com/jp/rss/customerreviews/id=\(id)/json")!
    }

    private static func url(_ path: String) -> URL {
        URL(string: rssBase + path)!
    }
}

private extension String {
    var urlEncoded: String {
        let charset = CharacterSet.alphanumerics.union(.init(charactersIn: "/?-._~"))
        let removed = removingPercentEncoding ?? self
        return removed.addingPercentEncoding(withAllowedCharacters: charset) ?? removed
    }
}
