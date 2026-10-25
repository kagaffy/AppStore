//
//  AppDetailsVC.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/09/29.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import UIKit

class AppDetailsVC: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    var data: DataSet = .empty
    var cellSize: CellSizePresenter = .empty

    var firstImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        registerAllCollectionViewCells(to: collectionView)
        navigationController?.navigationBar.isHidden = false
        fetchAppDetails()
        fetchReviews()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier, segue.destination) {
        case let ("showAllReviews", vc as AllReviewsVC):
            vc.data.appDetails = data.appDetails
            vc.data.reviews = data.reviews
        default: break
        }
    }

    func fetchAppDetails() {
        guard let id = data.id else { return }

        let width: CGFloat = UIScreen.main.bounds.width - 40
        GetAppDetails(id: id).execute(in: .background).then(in: .main) { [weak self] appDetails in
            self?.data.appDetails = appDetails
            self?.collectionView.reloadSections([SectionHandler.header.rawValue])
            self?.fetchImage(width: width)
        }
    }

    func fetchReviews() {
        guard let id = data.id else { return }

        GetReviews(id: id).execute(in: .background).then(in: .main) { [weak self] reviews in
            self?.data.reviews = reviews
            self?.collectionView.reloadSections([SectionHandler.reviewsSection])
        }
    }

    func fetchImage(width: CGFloat) {
        guard let urlString = data.appDetails?.screenshotUrls.first else { return }

        if let url = URL(string: urlString) {
            UIImageView().kf.setImage(with: url) { result in
                switch result {
                case let .success(imageValue):
                    let size = imageValue.image.size
                    if size.width > size.height {
                        self.firstImage = imageValue.image.resized(toWidth: width)
                    } else {
                        self.firstImage = imageValue.image.resized(toWidth: width * 2 / 3)
                    }
                    self.collectionView.reloadSections([SectionHandler.imagesSection])
                default: break
                }
            }
        }
    }
}

extension AppDetailsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //
    // MARK: UICollectionViewDataSource
    //

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        SectionHandler.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch SectionHandler(section) {
        case .information:
            AppDetailsInformationCell.CellKindPresenter.allCases.count
        default:
            SectionHandler.defaultNumberOfItems
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let appDetails = data.appDetails
        let reviews = data.reviews
        switch SectionHandler(indexPath.section) {
        case .header:
            let cell = AppDetailsHeaderCell.dequeue(from: collectionView, for: indexPath, with: appDetails)
            return cell
        case .images:
            let cell = AppDetailsImagesCell.dequeue(from: collectionView, for: indexPath, with: appDetails)
            cell.firstImage = firstImage
            cell.delegate = self
            return cell
        case .text:
            let cell = AppDetailsTextCell.dequeue(from: collectionView, for: indexPath, with: appDetails)
            cell.buttonTapped = cellSize.textCellShowMoreButtonTapped
            cell.delegate = self
            return cell
        case .reviews:
            let cell = AppDetailsReviewsCell.dequeue(from: collectionView, for: indexPath, with: reviews)
            cell.apply(appDetails: appDetails)
            return cell
        case .update:
            let cell = AppDetailsUpdateCell.dequeue(from: collectionView, for: indexPath, with: appDetails)
            cell.buttonTapped = cellSize.updateCellShowMoreButtonTapped
            cell.delegate = self
            return cell
        case .information:
            guard let appDetails, let cellKind = AppDetailsInformationCell.CellKindPresenter(indexPath.item) else { return UICollectionViewCell() }

            let cell = AppDetailsInformationCell.dequeue(from: collectionView, for: indexPath, with: (appDetails, cellKind))
            return cell
        default: return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cellKind = AppDetailsSectionHeaderCell.CellKindPresenter(indexPath.section)

        let cell = AppDetailsSectionHeaderCell.dequeue(from: collectionView, of: kind, for: indexPath, with: cellKind)
        cell.delegate = self
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
        case .header:
            return AppDetailsHeaderCell.estimatedSize(with: width)
        case .images:
            return AppDetailsImagesCell.estimatedSize(width: width, image: firstImage)
        case .text:
            return AppDetailsTextCell.estimatedSize(width: width, height: cellSize.textCellHeight)
        case .reviews:
            return AppDetailsReviewsCell.estimatedSize(with: width)
        case .update:
            return AppDetailsUpdateCell.estimatedSize(width: width, height: cellSize.updateCellHeight)
        case .information:
            return AppDetailsInformationCell.estimatedSize(with: width)
        default: return .zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch SectionHandler(section) {
        case .information:
            0
        default: 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.bounds.width
        let cellKind = AppDetailsSectionHeaderCell.CellKindPresenter(section)

        return AppDetailsSectionHeaderCell.estimatedSize(with: width, cellKind: cellKind)
    }
}

extension AppDetailsVC {
    struct DataSet {
        var id: String?
        var appDetails: AppDetails?
        var reviews: [Review]?
        static let empty: DataSet = .init()
    }
}

extension AppDetailsVC {
    struct CellSizePresenter {
        var textCellHeight: CGFloat = 190
        var textCellShowMoreButtonTapped: Bool = false

        var updateCellHeight: CGFloat = 135
        var updateCellShowMoreButtonTapped: Bool = false

        static let empty: CellSizePresenter = .init()
    }
}

extension AppDetailsVC {
    private enum SectionHandler: Int, CaseIterable {
        case header
        case images
        case text
        case reviews
        case update
        case information

        static var imagesIndexPath: IndexPath {
            .init(item: defaultNumberOfItems - 1, section: imagesSection)
        }

        static var imagesSection: Int {
            images.rawValue
        }

        static var textSection: Int {
            text.rawValue
        }

        static var reviewsSection: Int {
            reviews.rawValue
        }

        static var updateSection: Int {
            update.rawValue
        }

        static let defaultNumberOfItems = 1

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
    }
}

extension AppDetailsVC: CollectionViewRegister {
    var cellTypes: [UICollectionViewCell.Type] {
        [
            AppDetailsHeaderCell.self,
            AppDetailsImagesCell.self,
            AppDetailsTextCell.self,
            AppDetailsReviewsCell.self,
            AppDetailsUpdateCell.self,
            AppDetailsInformationCell.self,
        ]
    }

    var headerCellTypes: [UICollectionReusableView.Type] {
        [
            AppDetailsSectionHeaderCell.self,
        ]
    }
}

extension AppDetailsVC: AppDetailsImageCellDelegate {
    func appDetailsImageCell(estimatedSize size: CGSize?) {}
}

extension AppDetailsVC: AppDetailsTextCellDelegate {
    func appDetailsTextCell(labelSizeToFit height: CGFloat) {
        cellSize.textCellHeight += height
        cellSize.textCellShowMoreButtonTapped = true
        collectionView.reloadSections([SectionHandler.textSection])
    }
}

extension AppDetailsVC: AppDetailsUpdateCellDelegate {
    func appDetailsUpdateCell(labelSizeToFit height: CGFloat) {
        cellSize.updateCellHeight += height
        cellSize.updateCellShowMoreButtonTapped = true
        collectionView.reloadSections([SectionHandler.updateSection])
    }
}

extension AppDetailsVC: AppDetailsSectionHeaderCellDelegate {
    func appDetailsSectionHeaderCell(didTapReviewButton cell: AppDetailsSectionHeaderCell) {
        performSegue(withIdentifier: "showAllReviews", sender: nil)
    }

    func appDetailsSectionHeaderCell(didTapUpdateButton cell: AppDetailsSectionHeaderCell) {}
}
