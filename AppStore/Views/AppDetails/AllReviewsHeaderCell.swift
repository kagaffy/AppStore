//
//  AllReviewsHeaderCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/12/28.
//

import Presentation
import UIKit

final class AllReviewsHeaderCell: UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet weak var auxiliaryView: ReviewAuxiliaryView!

    static func estimatedSize(with width: CGFloat) -> CGSize {
        .init(width: width, height: 150)
    }

    //
    // MARK: CollectionViewCellPresenter
    //

    typealias T = AppDetailsModel
    var data: AppDetailsModel?

    func apply(with data: AppDetailsModel?) {
        let appDetails = data
        auxiliaryView.apply(appDetails: appDetails)
    }
}
