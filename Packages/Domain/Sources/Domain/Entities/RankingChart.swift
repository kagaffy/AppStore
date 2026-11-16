import Foundation

/// ランキングチャート種別。見出しはクライアント固定（API の title に依存しない）。
public enum RankingChart: String, CaseIterable, Sendable, Equatable {
    case recommendedNewApps
    case topFree
    case ipadTopFree
    case topSales
    case ipadTopSales
    case topPaid
    case recommendedNewGames
    case topFreeGames
    case topPaidGames

    public var displayTitle: String {
        switch self {
        case .recommendedNewApps: return "新着アプリ"
        case .topFree: return "トップ無料App"
        case .ipadTopFree: return "トップ無料iPad"
        case .topSales: return "トップセールス"
        case .ipadTopSales: return "トップセールスiPad"
        case .topPaid: return "トップ有料"
        case .recommendedNewGames: return "新着ゲーム"
        case .topFreeGames: return "トップ無料ゲーム"
        case .topPaidGames: return "トップ有料ゲーム"
        }
    }
}
