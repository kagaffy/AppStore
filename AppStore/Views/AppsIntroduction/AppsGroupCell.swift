//
//  AppsGroupCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/08/25.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import Domain
import Foundation
import UIKit

protocol AppsGroupCellDelegate: AnyObject {
    var classType: String { get }
    func appsGroupCell(allDisplayButtonTappedWith appsGroup: AppsGroup?)
    func appsGroupCell(didSelectAppIdWith id: String)
}

final class AppsGroupCell: UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var allDisplayButton: UIButton!
    @IBOutlet weak var appsCarouselView: AppsCarouselView!

    var delegate: AppsGroupCellDelegate?

    let titleLabelHeight: CGFloat = 20

    func setUpAppsCarouselView(with appsGroup: AppsGroup) {
        appsCarouselView.data.apps = appsGroup.apps
        appsCarouselView.delegate = self
        appsCarouselView.collectionView.reloadData()
    }

    func insertSectionLine() {
        let frame = CGRect(
            x: bounds.origin.x + IntroductionVC.DataSet.appsCarouselCellHorizontalSectionInset,
            y: bounds.origin.y + bounds.height - 1,
            width: bounds.width - IntroductionVC.DataSet.appsCarouselCellHorizontalSectionInset * 2,
            height: 0.5
        )
        let view = UIView(frame: frame)
        view.backgroundColor = .lightGray
        contentView.addSubview(view)
    }

    #warning("TODO: title conversion")
    func titleConversion() {
        let title = TitleConversion(delegate?.classType, titleLabel.text)?.rawValue
        titleLabel.text = title
//        data?.title = title ?? ""
    }

    @IBAction func allDisplayButtonTapped(_ sender: Any) {
        delegate?.appsGroupCell(allDisplayButtonTappedWith: data)
    }

    //
    // MARK: CollectionViewCellPresenter
    //

    typealias T = AppsGroup
    var data: AppsGroup?

    func apply(with data: AppsGroup?) {
        guard let appsGroup = data else { return }

        titleLabel.text = appsGroup.title
        setUpAppsCarouselView(with: appsGroup)
        insertSectionLine()
    }
}

extension AppsGroupCell {
    private enum TitleConversion: String {
        case recommendedNewGames = "おすすめの新着ゲーム"
        case topFreeGames = "トップ無料ゲーム"
        case topPaidGames = "トップ有料ゲーム"
        case recommendedNewApps = "おすすめの新着App"
        case topFree = "トップ無料App"
        case ipadTopFree = "トップ無料iPad"
        case topSalesApp = "トップセールス"
        case ipadTopSales = "トップセールスiPad"
        case topPaid = "トップ有料"

        static let recommendedNewGamesTitle = "おすすめの新着ゲーム"
        static let topFreeGamesTitle = "Top Free iPhone Apps"
        static let topPaidGamesTitle = "Top Paid iPhone Apps"
        static let recommendedNewAppsTitle = "おすすめの新着App"
        static let topFreeTitle = "Top Free iPhone Apps"
        static let ipadTopFreeTitle = "Top Free iPad Apps"
        static let topSalesAppTitle = "Top Grossing iPhone Apps"
        static let ipadTopSalesTitle = "Top Grossing iPad Apps"
        static let topPaidTitle = "Top Paid iPhone Apps"

        init?(_ classType: String?, _ title: String?) {
            let game = String(describing: GamesIntroductionVC.self)
            let app = String(describing: AppsIntroductionVC.self)

            switch (classType, title) {
            case (game, type(of: self).recommendedNewGamesTitle): self = type(of: self).recommendedNewGames
            case (game, type(of: self).topFreeGamesTitle): self = type(of: self).topFreeGames
            case (game, type(of: self).topPaidGamesTitle): self = type(of: self).topPaidGames
            case (app, type(of: self).recommendedNewAppsTitle): self = type(of: self).recommendedNewApps
            case (app, type(of: self).topFreeTitle): self = type(of: self).topFree
            case (app, type(of: self).ipadTopFreeTitle): self = type(of: self).ipadTopFree
            case (app, type(of: self).topSalesAppTitle): self = type(of: self).topSalesApp
            case (app, type(of: self).ipadTopSalesTitle): self = type(of: self).ipadTopSales
            case (app, type(of: self).topPaidTitle): self = type(of: self).topPaid
            default: return nil
            }
        }
    }
}

extension AppsGroupCell: AppsCarouselViewDelegate {
    func appsCarouselView(didSelectAppIdWith id: String) {
        delegate?.appsGroupCell(didSelectAppIdWith: id)
    }
}
