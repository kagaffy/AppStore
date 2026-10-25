//
//  IntroductionVC.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/08/23.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import AppData
import Domain
import Hydra
import UIKit

class IntroductionVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    var data: DataSet = .empty
    var accessUrls: [URL] {
        [
            // Must override `accessUrls` in IntroductionVC subclass.
        ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerAllCollectionViewCells(to: collectionView)
        fetchApps()
    }

    override func loadView() {
        if let view = UINib(nibName: String(describing: IntroductionVC.self), bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView {
            self.view = view
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (SegueType(segue.identifier), segue.destination) {
        case let (.showIntroductionListUpVC, vc as IntroductionListUpVC):
            guard let appsGroup = sender as! AppsGroup? else { return }
            vc.data.appsGroup = appsGroup
        case let (.showAppDetailsVC, vc as AppDetailsVC):
            guard let id = sender as! String? else { return }
            vc.data.id = id
        default: break
        }
    }

    func fetchApps() {
        accessUrls.forEach { url in
            GetAppsGroup(url: url).execute(in: .background).then(in: .main) { [weak self] appsGroup in
                if let appsGroup {
                    self?.data.appsGroups.append(appsGroup)
                    let indexPath = IndexPath(row: (self?.data.appsGroups.count ?? 1) - 1, section: SectionHandler.appsGroupSection)
                    self?.collectionView.insertItems(at: [indexPath])
                }
            }
        }
    }
}

extension IntroductionVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //
    // MARK: UICollectionViewDataSource
    //

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        SectionHandler.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch SectionHandler(section) {
        case .appsGroupHeader?:
            0
        case .appsGroup?:
            data.appsGroups.count
        default: 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch SectionHandler(indexPath.section) {
        case .appsGroupHeader?:
            return UICollectionViewCell()
        case .appsGroup?:
            let appsGroup = data.appsGroups[indexPath.item]
            let cell = AppsGroupCell.dequeue(from: collectionView, for: indexPath, with: appsGroup)
            cell.delegate = self
            cell.titleConversion()
            return cell
        default: return UICollectionViewCell()
        }
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
        case .appsGroupHeader?:
            return .zero
        case .appsGroup?:
            return .init(width: width, height: DataSet.appsGroupCellHeight)
        default: return .zero
        }
    }
}

extension IntroductionVC: AppsGroupCellDelegate {
    var classType: String {
        String(describing: type(of: self))
    }

    func appsGroupCell(allDisplayButtonTappedWith appsGroup: AppsGroup?) {
        performSegue(withIdentifier: SegueType.showIntroductionListUpVC.rawValue, sender: appsGroup)
    }

    func appsGroupCell(didSelectAppIdWith id: String) {
        performSegue(withIdentifier: SegueType.showAppDetailsVC.rawValue, sender: id)
    }
}

extension IntroductionVC {
    struct DataSet {
        var appsGroups: [AppsGroup] = []
        static let empty: DataSet = .init()

        static let appsGroupTitleLabelHeight: CGFloat = 30
        static let appsGroupTitleLabelSpacing: CGFloat = 10
        static var appsGroupCellHeight: CGFloat {
            appsGroupTitleLabelHeight
                + appsGroupTitleLabelSpacing * 2
                + appsCarouselCellHeight * 3
                + appsCarouselCellVerticalSpacing * 2
        }

        static var appsCarouselCellHeight: CGFloat {
            appsCarouselImageWidth + appsCarouselImageSpacing * 2
        }

        static let appsCarouselImageWidth: CGFloat = 70
        static let appsCarouselImageSpacing: CGFloat = 10
        static let appsCarouselCellVerticalSpacing: CGFloat = 0
        static let appsCarouselCellHorizontalSpacing: CGFloat = 10
        static let appsCarouselCellHorizontalSectionInset: CGFloat = 20

        static func appsCarouselCellWidth(_ width: CGFloat) -> CGFloat {
            width - appsCarouselCellHorizontalSectionInset * 2
        }
    }
}

extension IntroductionVC {
    private enum SectionHandler: Int, CaseIterable {
        case appsGroupHeader
        case appsGroup

        static var appsGroupSection: Int {
            appsGroup.rawValue
        }

        init?(_ section: Int) {
            switch section {
            case type(of: self).appsGroupHeader.rawValue: self = .appsGroupHeader
            case type(of: self).appsGroup.rawValue: self = .appsGroup
            default: return nil
            }
        }
    }
}

extension IntroductionVC {
    enum SegueType: String {
        case showIntroductionListUpVC
        case showAppDetailsVC

        init?(_ identifier: String?) {
            self.init(rawValue: identifier ?? "")
        }
    }
}

extension IntroductionVC: CollectionViewRegister {
    var cellTypes: [UICollectionViewCell.Type] {
        [
            AppsGroupCell.self,
        ]
    }
}

extension IntroductionVC: ScrollableToTop {
    var scrollableView: Any? {
        collectionView
    }
}
