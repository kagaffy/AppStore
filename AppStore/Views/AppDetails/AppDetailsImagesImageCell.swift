//
//  AppDetailsImagesImageCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/12/05.
//

import Foundation
import UIKit

protocol AppDetailsImagesImageCellDelegate: AnyObject {
    func appDetailsImagesImageCell(estimatedSize size: CGSize?)
}

final class AppDetailsImagesImageCell: UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet weak var imageView: UIImageView!

    var delegate: AppDetailsImagesImageCellDelegate?

    //
    // MARK: CollectionViewCellPresenter
    //

    typealias T = String
    var data: String?

    func apply(with data: String?) {
        guard let data else { return }

        if let url = URL(string: data) {
            imageView.kf.setImage(with: url)
        }
    }
}
