//
//  AppDetailsSectionHeaderCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/11/26.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import Foundation
import UIKit

protocol AppDetailsSectionHeaderCellDelegate: AnyObject {
    func appDetailsSectionHeaderCell(didTapReviewButton cell: AppDetailsSectionHeaderCell)
    func appDetailsSectionHeaderCell(didTapUpdateButton cell: AppDetailsSectionHeaderCell)
}

final class AppDetailsSectionHeaderCell: UICollectionReusableView, CollectionReusableViewPresenter {
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!

    var delegate: AppDetailsSectionHeaderCellDelegate?

    private var cellKind: CellKindPresenter?

    var titles: (String, String)? {
        cellKind?.title
    }

    static func estimatedSize(with width: CGFloat, cellKind: CellKindPresenter?) -> CGSize {
        guard let cellKind else { return .zero }

        switch cellKind {
        case .reviews, .update, .information:
            return .init(width: width, height: 40)
        default: return .zero
        }
    }

    func showAllReviews() {
        delegate?.appDetailsSectionHeaderCell(didTapReviewButton: self)
    }

    func showUpdate() {
        delegate?.appDetailsSectionHeaderCell(didTapUpdateButton: self)
    }

    @IBAction func rightButtonTapped(_ sender: Any) {
        switch cellKind {
        case .reviews:
            showAllReviews()
        case .update:
            showUpdate()
        default: break
        }
    }

    //
    // MARK: CollectionReusableViewPresenter
    //

    typealias T = CellKindPresenter
    var data: CellKindPresenter?

    func apply(with data: CellKindPresenter?) {
        cellKind = data

        sectionTitleLabel.text = titles?.0
        rightButton.setTitle(titles?.1, for: .normal)
    }
}

extension AppDetailsSectionHeaderCell {
    enum CellKindPresenter: Int {
        case header
        case images
        case text
        case reviews
        case update
        case information

        init?(_ section: Int) {
            switch section {
            case type(of: self).header.rawValue: self = .header
            case type(of: self).images.rawValue: self = .images
            case type(of: self).text.rawValue: self = .text
            case type(of: self).reviews.rawValue: self = .reviews
            case type(of: self).update.rawValue: self = .update
            case type(of: self).information.rawValue: self = .information
            default: return nil
            }
        }

        var title: (String, String) {
            switch self {
            case .reviews:
                ("評価とレビュー", "すべて表示")
            case .update:
                ("アップデート", "バージョン履歴")
            case .information:
                ("情報", "")
            default: ("", "")
            }
        }
    }
}
