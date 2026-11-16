//
//  AppDetailsReviewCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/12/17.
//

import Presentation
import UIKit

final class AppDetailsReviewCell: UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var showMoreButton: UIButton!

    static func estimatedSize(with width: CGFloat) -> CGSize {
        .init(width: width - 20 * 2, height: 250)
    }

    //
    // MARK: CollectionViewCellPresenter
    //

    typealias T = ReviewModel
    var data: ReviewModel?

    func apply(with data: ReviewModel?) {
        guard let review = data else { return }

        titleLabel.text = review.title
        ratingLabel.text = String(repeating: "⭐️", count: Int(review.rating) ?? 1)
        nameLabel.text = review.name
        reviewLabel.text = review.content
    }
}
