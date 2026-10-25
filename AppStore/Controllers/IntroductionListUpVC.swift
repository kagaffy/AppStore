//
//  IntroductionListUpVC.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/09/24.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import AppData
import Domain
import UIKit

class IntroductionListUpVC: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    var data: DataSet = .empty

    override func viewDidLoad() {
        super.viewDidLoad()
        registerAllCollectionViewCells(to: collectionView)
        applyNavigationItem()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier, segue.destination) {
        case let ("showAppDetailsVC", vc as AppDetailsVC):
            let app = sender as! App
            vc.data.id = app.id
        default: break
        }
    }

    func applyNavigationItem() {
        navigationItem.title = data.appsGroup?.title
    }
}

extension IntroductionListUpVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //
    // MARK: UICollectionViewDataSource
    //

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.appsGroup?.apps.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let app = data.appsGroup?.apps[indexPath.item] else { return UICollectionViewCell() }

        let cell = IntroductionListUpCell.dequeue(from: collectionView, for: indexPath, with: app)
        cell.insertSectionLineIfNeeded(indexPath.item - 1 < data.appsGroup?.apps.count ?? 0)
        return cell
    }

    //
    // MARK: UICollectionViewDelegate
    //

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let app = data.appsGroup?.apps[indexPath.item] else { return }

        performSegue(withIdentifier: "showAppDetailsVC", sender: app)
    }

    //
    // MARK: UICollectionViewDelegateFlowLayout
    //

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return .init(width: DataSet.cellWidth(width), height: DataSet.cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        DataSet.cellEdge
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        DataSet.cellSpacing
    }
}

extension IntroductionListUpVC {
    struct DataSet {
        var appsGroup: AppsGroup?
        static let empty: DataSet = .init()

        static let iconImageWidth: CGFloat = 95
        static let iconImageSpacing: CGFloat = 15
        static func cellWidth(_ collectionViewWidth: CGFloat) -> CGFloat {
            collectionViewWidth - cellEdge.left - cellEdge.right
        }

        static var cellHeight: CGFloat {
            iconImageWidth + iconImageSpacing * 2
        }

        static var cellEdge: UIEdgeInsets {
            .init(
                top: 0,
                left: 20,
                bottom: 0,
                right: 20
            )
        }

        static let cellSpacing: CGFloat = 0
    }
}

extension IntroductionListUpVC: CollectionViewRegister {
    var cellTypes: [UICollectionViewCell.Type] {
        [
            IntroductionListUpCell.self,
        ]
    }
}
