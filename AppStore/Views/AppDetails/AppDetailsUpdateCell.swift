//
//  AppDetailsUpdateCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/09/29.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import UIKit

protocol AppDetailsUpdateCellDelegate: AnyObject {
    func appDetailsUpdateCell(labelSizeToFit height: CGFloat)
}

final class AppDetailsUpdateCell: UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet weak var newestVersionLabel: UILabel!
    @IBOutlet weak var updateDateLabel: UILabel!
    @IBOutlet weak var updateDetailsLabel: UILabel!
    @IBOutlet weak var showMoreButton: UIButton!

    var delegate: AppDetailsUpdateCellDelegate?

    var buttonTapped: Bool = false {
        didSet {
            showMoreButton.isHidden = buttonTapped
        }
    }

    static func estimatedSize(width: CGFloat, height: CGFloat = 135) -> CGSize {
        .init(width: width, height: height)
    }

    @IBAction func showMoreButtonTapped(_ sender: Any) {
        let beforeWidth = updateDetailsLabel.frame.height
        updateDetailsLabel.sizeToFit()
        let afterWidth = updateDetailsLabel.frame.height
        delegate?.appDetailsUpdateCell(labelSizeToFit: afterWidth - beforeWidth)
    }

    //
    // MARK: CollectionViewCellPresenter
    //

    typealias T = AppDetails
    var data: AppDetails?

    func apply(with data: AppDetails?) {
        guard let appDetails = data else { return }

        newestVersionLabel.text = "バージョン\(appDetails.version)"
        updateDateLabel.text = appDetails.currentVersionReleaseDate?.toISO([.withFullDate])
        updateDetailsLabel.text = appDetails.releaseNotes
    }
}
