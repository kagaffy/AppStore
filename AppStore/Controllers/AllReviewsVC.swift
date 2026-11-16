//
//  AllReviewsVC.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/12/28.
//

import AppData
import Domain
import UIKit

class AllReviewsVC: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    var data: DataSet = .empty

    override func viewDidLoad() {
        super.viewDidLoad()

        registerAllCollectionViewCells(to: collectionView)
    }
}

extension AllReviewsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //
    // MARK: UICollectionViewDataSource
    //

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        SectionHandler.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch SectionHandler(section) {
        case .reviews:
            data.reviews?.count ?? 0
        default:
            SectionHandler.defaultNumberOfItem
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch SectionHandler(indexPath.section) {
        case .heading:
            let cell = AllReviewsHeaderCell.dequeue(from: collectionView, for: indexPath, with: data.appDetails)
            return cell
        case .reviews:
            let cell = AppDetailsReviewCell.dequeue(from: collectionView, for: indexPath, with: data.reviews?[indexPath.item])
            return cell
        default: return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cellKind = AllReviewsSectionHeaderCell.CellKindPresenter(indexPath.section)

        let cell = AllReviewsSectionHeaderCell.dequeue(from: collectionView, of: kind, for: indexPath, with: cellKind)
        return cell
    }

    //
    // MARK: UICollectionViewDelegate
    //

    //
    // MARK: UICollectionViewDelegateFlowLayout
    //

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width

        switch SectionHandler(indexPath.section) {
        case .heading:
            return AllReviewsHeaderCell.estimatedSize(with: width)
        case .reviews:
            return AppDetailsReviewCell.estimatedSize(with: width)
        default: return .zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 20, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        15
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.bounds.width
        let cellKind = AllReviewsSectionHeaderCell.CellKindPresenter(section)

        return AllReviewsSectionHeaderCell.estimatedSize(with: width, cellKind: cellKind)
    }
}

extension AllReviewsVC {
    struct DataSet {
        var appDetails: AppDetails?
        var reviews: [Review]?
        static let empty: DataSet = .init()
    }
}

extension AllReviewsVC {
    private enum SectionHandler: Int, CaseIterable {
        case heading
        case reviews

        static let defaultNumberOfItem = 1

        init?(_ section: Int) {
            switch section {
            case type(of: self).heading.rawValue: self = .heading
            case type(of: self).reviews.rawValue: self = .reviews
            default: return nil
            }
        }
    }
}

extension AllReviewsVC: CollectionViewRegister {
    var cellTypes: [UICollectionViewCell.Type] {
        [
            AllReviewsHeaderCell.self,
            AppDetailsReviewCell.self,
        ]
    }

    var headerCellTypes: [UICollectionReusableView.Type] {
        [
            AllReviewsSectionHeaderCell.self,
        ]
    }
}
