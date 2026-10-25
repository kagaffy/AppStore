//
//  AppDetailsTextCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/09/29.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import UIKit

protocol AppDetailsTextCellDelegate: AnyObject {
    func appDetailsTextCell(labelSizeToFit height: CGFloat)
}

final class AppDetailsTextCell: UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet weak var mainTextLabel: UILabel!
    @IBOutlet weak var showMoreButton: UIButton!
    @IBOutlet weak var developerView: UIStackView!
    @IBOutlet weak var developerNameLabel: UILabel!

    var delegate: AppDetailsTextCellDelegate?

    var buttonTapped: Bool = false {
        didSet {
            showMoreButton.isHidden = buttonTapped
        }
    }

    static func estimatedSize(width: CGFloat, height: CGFloat = 190) -> CGSize {
        .init(width: width, height: height)
    }

    @IBAction func showMoreButtonTapped(_ sender: Any) {
        let beforeWidth = mainTextLabel.frame.height
        mainTextLabel.sizeToFit()
        let afterWidth = mainTextLabel.frame.height
        delegate?.appDetailsTextCell(labelSizeToFit: afterWidth - beforeWidth)
    }

    //
    // MARK: CollectionViewCellPresenter
    //

    typealias T = AppDetails
    var data: AppDetails?

    func apply(with data: AppDetails?) {
        guard let appDetails = data else { return }

        mainTextLabel.text = appDetails.description
        developerNameLabel.text = appDetails.sellerName
    }
}
