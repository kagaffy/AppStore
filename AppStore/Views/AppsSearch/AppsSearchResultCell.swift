//
//  AppsSearchResultCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/12/28.
//

import Domain
import Kingfisher
import UIKit

final class AppsSearchResultCell: UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var reviewAmountLabel: UILabel!
    @IBOutlet weak var imagesBackView: UIView!
    @IBOutlet weak var getButton: UIButton!

    func addImagesToBackView() {
        guard let urlString = data?.screenshotUrls.first else { return }

        let firstImageView = UIImageView()
        if let url = URL(string: urlString) {
            firstImageView.kf.setImage(with: url) { result in
                switch result {
                case let .success(imageValue):
                    let width = UIScreen.main.bounds.width - 20 * 2
                    let size = imageValue.image.size
                    if size.width > size.height {
                        firstImageView.frame.size = CGSize(width: width, height: size.height * (width / size.width))
                        firstImageView.clipsToBounds = true
                        firstImageView.layer.cornerRadius = 20
                        self.imagesBackView.addSubview(firstImageView)
                    } else {
                        self.addOtherImagesToBackViewWith(firstImageView)
                    }
                default: break
                }
            }
        }
    }

    func addOtherImagesToBackViewWith(_ firstImageView: UIImageView) {
        guard data?.screenshotUrls.count ?? 0 >= 3 else { return }

        let screenSize = UIScreen.main.bounds.size
        let width = (screenSize.width - 20 * 2 - 10 * 2) / 3
        let size = CGSize(width: width, height: screenSize.height * (width / screenSize.width))

        firstImageView.frame.size = size
        firstImageView.clipsToBounds = true
        firstImageView.layer.cornerRadius = 10
        imagesBackView.addSubview(firstImageView)

        [data?.screenshotUrls[1], data?.screenshotUrls[2]].enumerated().forEach { index, urlString in
            if let url = URL(string: urlString ?? "") {
                let imageView = UIImageView()
                imageView.kf.setImage(with: url)
                imageView.frame.origin.x += CGFloat(index + 1) * (size.width + 10)
                imageView.frame.size = size
                imageView.clipsToBounds = true
                imageView.layer.cornerRadius = 10
                imagesBackView.addSubview(imageView)
            }
        }
    }

    func removeAllSubviews(parentView: UIView) {
        parentView.subviews.forEach { subView in
            subView.removeFromSuperview()
        }
    }

    static func estimatedSize(with width: CGFloat) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = width - 20 * 2
        let backViewHeight = (cellWidth - 10 * 2) / 3 * (screenSize.height / screenSize.width)
        let cellHeight = 80 + 20 + backViewHeight
        return .init(width: cellWidth, height: cellHeight)
    }

    //
    // MARK: CollectionViewCellPresenter
    //

    typealias T = AppDetails
    var data: AppDetails?

    func apply(with data: AppDetails?) {
        removeAllSubviews(parentView: imagesBackView)
        guard let appDetails = data else { return }

        titleLabel.text = appDetails.trackName
        reviewAmountLabel.text = String(appDetails.userRatingCount)
        getButton.setTitle(appDetails.price, for: .normal)

        if let url = URL(string: appDetails.iconUrl) {
            iconImageView.kf.setImage(with: url)
        }

        addImagesToBackView()
    }
}
