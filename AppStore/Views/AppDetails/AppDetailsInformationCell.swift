//
//  AppDetailsInformationCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/09/29.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import Domain
import UIKit

final class AppDetailsInformationCell: UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!

    private var cellKind: CellKindPresenter?

//    var isTapEnable: Bool? {
//        return cellKind?.isTapEnable
//    }

    var title: String? {
        cellKind?.title
    }

    static func estimatedSize(with width: CGFloat) -> CGSize {
        .init(width: width, height: 50)
    }

    //
    // MARK: CollectionViewCellPresenter
    //

    typealias T = (AppDetails, CellKindPresenter)
    var data: (AppDetails, CellKindPresenter)?

    func apply(with data: (AppDetails, CellKindPresenter)?) {
        cellKind = data?.1
        titleLabel.text = title

        guard let appDetails = data?.0 else { return }

        switch cellKind {
        case .distributor:
            itemLabel.text = appDetails.sellerName
        case .dataSize:
            itemLabel.text = "\(appDetails.fileSizeBytes)Bytes"
        case .category:
            itemLabel.text = appDetails.genres.first
        case .compatible:
            itemLabel.text = appDetails.supportedDevices.first
        case .language:
            itemLabel.text = appDetails.languageCodes.first
        case .ageLimit:
            itemLabel.text = appDetails.ageLimit
        case .billing:
            itemLabel.text = "なし"
        default: break
        }
    }
}

extension AppDetailsInformationCell {
    enum CellKindPresenter: Int, CaseIterable {
        case distributor
        case dataSize
        case category
        case compatible
        case language
        case ageLimit
        case billing

        init?(_ index: Int) {
            switch index {
            case type(of: self).distributor.rawValue: self = .distributor
            case type(of: self).dataSize.rawValue: self = .dataSize
            case type(of: self).category.rawValue: self = .category
            case type(of: self).compatible.rawValue: self = .compatible
            case type(of: self).language.rawValue: self = .language
            case type(of: self).ageLimit.rawValue: self = .ageLimit
            case type(of: self).billing.rawValue: self = .billing
            default: return nil
            }
        }

//        var isTapEnable: Bool {
//            switch self {
//            case .distributor, .dataSize:
//                return false
//            case .category, .compatible, .language, .ageLimit, .billing:
//                return true
//            default: return false
//            }
//        }

        var title: String {
            switch self {
            case .distributor:
                "販売元"
            case .dataSize:
                "サイズ"
            case .category:
                "カテゴリ"
            case .compatible:
                "互換性"
            case .language:
                "言語"
            case .ageLimit:
                "年齢制限"
            case .billing:
                "App内課金"
            default: ""
            }
        }
    }
}
