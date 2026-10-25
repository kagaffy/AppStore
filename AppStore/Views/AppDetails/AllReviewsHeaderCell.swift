//
//  AllReviewsHeaderCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/12/28.
//

import UIKit

final class AllReviewsHeaderCell: UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet weak var auxiliaryView: ReviewAuxiliaryView!

    static func estimatedSize(with width: CGFloat) -> CGSize {
        .init(width: width, height: 150)
    }

    //
    // MARK: CollectionViewCellPresenter
    //

    typealias T = AppDetails
    var data: AppDetails?

    func apply(with data: AppDetails?) {
        let appDetails = data
        auxiliaryView.apply(appDetails: appDetails)
    }
}
