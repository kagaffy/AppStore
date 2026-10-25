//
//  AppDetailsHeaderCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/09/29.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import UIKit

final class AppDetailsHeaderCell: UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var billingLabel: UILabel!
    @IBOutlet weak var reviewAmountLabel: UILabel!
    @IBOutlet weak var targetAgeLabel: UILabel!

    static let iconWidth: CGFloat = 110

    static func estimatedSize(with width: CGFloat) -> CGSize {
        .init(width: width, height: 190)
    }

    //
    // MARK: CollectionViewCellPresenter
    //

    typealias T = AppDetails
    var data: AppDetails?

    func apply(with data: AppDetails?) {
        guard let appDetails = data else { return }

        titleLabel.text = appDetails.trackName
        companyNameLabel.text = appDetails.sellerName
        getButton.setTitle(appDetails.price, for: .normal)
        reviewAmountLabel.text = "\(appDetails.userRatingCount)件の評価"
        targetAgeLabel.text = appDetails.ageLimit

        if let url = URL(string: appDetails.iconUrl) {
            iconImageView.kf.setImage(with: url)
        }
    }
}
