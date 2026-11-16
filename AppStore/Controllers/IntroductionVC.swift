//
//  IntroductionVC.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/08/23.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import Combine
import Domain
import Presentation
import UIKit

class IntroductionVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    var charts: [RankingChart] {
        [
            // Must override `charts` in IntroductionVC subclass.
        ]
    }

    private var viewModel: IntroductionViewModel?
    private var cancellables = Set<AnyCancellable>()
    private var displayedGroupCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        registerAllCollectionViewCells(to: collectionView)
        let viewModel = CompositionRoot.makeIntroductionViewModel(charts: charts)
        self.viewModel = viewModel
        bindViewModel(viewModel)
        viewModel.load()
    }

    override func loadView() {
        if let view = UINib(nibName: String(describing: IntroductionVC.self), bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView {
            self.view = view
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (SegueType(segue.identifier), segue.destination) {
        case let (.showIntroductionListUpVC, vc as IntroductionListUpVC):
            guard let appsGroup = sender as? AppsGroupModel else { return }
            vc.appsGroup = appsGroup
        case let (.showAppDetailsVC, vc as AppDetailsVC):
            guard let id = sender as? String else { return }
            vc.appID = id
        default: break
        }
    }

    private func bindViewModel(_ viewModel: IntroductionViewModel) {
        viewModel.$appsGroups
            .receive(on: RunLoop.main)
            .sink { [weak self] groups in
                guard let self else { return }
                let newCount = groups.count
                let oldCount = self.displayedGroupCount
                self.displayedGroupCount = newCount
                guard newCount > oldCount else {
                    if newCount == 0 {
                        self.collectionView.reloadSections([SectionHandler.appsGroupSection])
                    }
                    return
                }
                let indexPaths = (oldCount ..< newCount).map {
                    IndexPath(row: $0, section: SectionHandler.appsGroupSection)
                }
                self.collectionView.insertItems(at: indexPaths)
            }
            .store(in: &cancellables)
    }
}

extension IntroductionVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        SectionHandler.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch SectionHandler(section) {
        case .appsGroupHeader?:
            0
        case .appsGroup?:
            viewModel?.appsGroups.count ?? 0
        default: 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch SectionHandler(indexPath.section) {
        case .appsGroupHeader?:
            return UICollectionViewCell()
        case .appsGroup?:
            guard let appsGroup = viewModel?.appsGroups[indexPath.item] else {
                return UICollectionViewCell()
            }
            let cell = AppsGroupCell.dequeue(from: collectionView, for: indexPath, with: appsGroup)
            cell.delegate = self
            return cell
        default: return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width

        switch SectionHandler(indexPath.section) {
        case .appsGroupHeader?:
            return .zero
        case .appsGroup?:
            return .init(width: width, height: Layout.appsGroupCellHeight)
        default: return .zero
        }
    }
}

extension IntroductionVC: AppsGroupCellDelegate {
    func appsGroupCell(allDisplayButtonTappedWith appsGroup: AppsGroupModel?) {
        performSegue(withIdentifier: SegueType.showIntroductionListUpVC.rawValue, sender: appsGroup)
    }

    func appsGroupCell(didSelectAppIdWith id: String) {
        performSegue(withIdentifier: SegueType.showAppDetailsVC.rawValue, sender: id)
    }
}

extension IntroductionVC {
    enum Layout {
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

    /// Backward-compatible alias used by carousel layout helpers.
    typealias DataSet = Layout
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
