//
//  AppsCarouselView.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/08/26.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import Foundation
import UIKit

protocol AppsCarouselViewDelegate: AnyObject {
    func appsCarouselView(didSelectAppIdWith id: String)
}

class AppsCarouselView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!

    var data: DataSet = .empty
    var delegate: AppsCarouselViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        registerAllCollectionViewCells(to: collectionView)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
        registerAllCollectionViewCells(to: collectionView)
    }

    func loadNib() {
        if let view = UINib(nibName: String(describing: type(of: self)), bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView {
            view.frame = bounds
            addSubview(view)
        }
    }
}

extension AppsCarouselView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //
    // MARK: UICollectionViewDataSource
    //

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.apps.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard data.apps.count > 0 else { return UICollectionViewCell() }

        let app = data.apps[indexPath.item]
        let cell = AppsCarouselCell.dequeue(from: collectionView, for: indexPath, with: app)
        cell.insertSectionLineIfNeeded(indexPath.item % 3 != 2)
        return cell
    }

    //
    // MARK: UICollectionViewDelegate
    //

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        let id = data.apps[indexPath.item].id
        delegate?.appsCarouselView(didSelectAppIdWith: id)
    }

    //
    // MARK: UICollectionViewDelegateFlowLayout
    //

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return .init(width: IntroductionVC.DataSet.appsCarouselCellWidth(width), height: IntroductionVC.DataSet.appsCarouselCellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let spacing = IntroductionVC.DataSet.appsCarouselCellHorizontalSectionInset
        return .init(top: 0, left: spacing, bottom: 0, right: spacing)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        IntroductionVC.DataSet.appsCarouselCellHorizontalSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        IntroductionVC.DataSet.appsCarouselCellVerticalSpacing
    }
}

extension AppsCarouselView {
    struct DataSet {
        var apps: [App] = []
        static let empty: DataSet = .init()
    }
}

extension AppsCarouselView: CollectionViewRegister {
    var cellTypes: [UICollectionViewCell.Type] {
        [
            AppsCarouselCell.self,
        ]
    }
}
