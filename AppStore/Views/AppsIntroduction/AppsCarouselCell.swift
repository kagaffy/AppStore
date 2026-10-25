//
//  AppsCarouselCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/08/30.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit

final class AppsCarouselCell: UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var getButton: UIButton!

    var iconWidth: CGFloat {
        IntroductionVC.DataSet.appsCarouselImageWidth
    }

    func insertSectionLineIfNeeded(_ required: Bool) {
        guard required else { return }

        let xIndex = IntroductionVC.DataSet.appsCarouselImageWidth + IntroductionVC.DataSet.appsCarouselImageSpacing
        let frame = CGRect(
            x: bounds.origin.x + xIndex,
            y: bounds.origin.y + bounds.height - 1,
            width: bounds.width - xIndex,
            height: 0.5
        )
        let view = UIView(frame: frame)
        view.backgroundColor = .lightGray
        contentView.addSubview(view)
    }

    //
    // MARK: CollectionViewCellPresenter
    //

    typealias T = App
    var data: App?

    func apply(with data: App?) {
        iconImageView.image = nil
        guard let app = data else { return }

        titleLabel.text = app.name
        iconImageView.kf.setImage(with: app.iconUrl)
    }
}
