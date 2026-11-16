//
//  AppsGroupCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/08/25.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import Foundation
import Presentation
import UIKit

protocol AppsGroupCellDelegate: AnyObject {
    func appsGroupCell(allDisplayButtonTappedWith appsGroup: AppsGroupModel?)
    func appsGroupCell(didSelectAppIdWith id: String)
}

final class AppsGroupCell: UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var allDisplayButton: UIButton!
    @IBOutlet weak var appsCarouselView: AppsCarouselView!

    var delegate: AppsGroupCellDelegate?

    let titleLabelHeight: CGFloat = 20

    func setUpAppsCarouselView(with appsGroup: AppsGroupModel) {
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

    @IBAction func allDisplayButtonTapped(_ sender: Any) {
        delegate?.appsGroupCell(allDisplayButtonTappedWith: data)
    }

    typealias T = AppsGroupModel
    var data: AppsGroupModel?

    func apply(with data: AppsGroupModel?) {
        guard let appsGroup = data else { return }

        titleLabel.text = appsGroup.title
        setUpAppsCarouselView(with: appsGroup)
        insertSectionLine()
    }
}

extension AppsGroupCell: AppsCarouselViewDelegate {
    func appsCarouselView(didSelectAppIdWith id: String) {
        delegate?.appsGroupCell(didSelectAppIdWith: id)
    }
}
