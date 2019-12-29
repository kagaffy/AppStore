//
//  AppsCarouselCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/08/30.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher

final class AppsCarouselCell : UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var getButton: UIButton!
    
    var iconWidth: CGFloat {
        return IntroductionVC.DataSet.appsCarouselImageWidth
    }

    func insertSectionLineIfNeeded(_ required: Bool) {
        guard required else { return }
        
        let xIndex = IntroductionVC.DataSet.appsCarouselImageWidth + IntroductionVC.DataSet.appsCarouselImageSpacing
        let frame = CGRect(
            x: self.bounds.origin.x + xIndex,
            y: self.bounds.origin.y + self.bounds.height - 1,
            width: self.bounds.width - xIndex,
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
        
        if let url = URL(string: app.iconUrl) {
            iconImageView.kf.setImage(with: url)
        }
    }
}
