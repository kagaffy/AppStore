//
//  AllReviewsSectionHeaderCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/12/28.
//

import UIKit

final class AllReviewsSectionHeaderCell: UICollectionReusableView, CollectionReusableViewPresenter {
    private var cellKind: CellKindPresenter?

    static func estimatedSize(with width: CGFloat, cellKind: CellKindPresenter?) -> CGSize {
        guard let cellKind else { return .zero }

        switch cellKind {
        case .heading:
            return .init(width: width, height: 50)
        default: return .zero
        }
    }

    //
    // MARK: CollectionReusableViewPresenter
    //

    typealias T = CellKindPresenter
    var data: CellKindPresenter?

    func apply(with data: CellKindPresenter?) {
        cellKind = data
    }
}

extension AllReviewsSectionHeaderCell {
    enum CellKindPresenter: Int {
        case heading
        case reviews

        init?(_ section: Int) {
            switch section {
            case type(of: self).heading.rawValue: self = .heading
            case type(of: self).reviews.rawValue: self = .reviews
            default: return nil
            }
        }
    }
}
