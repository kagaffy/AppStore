//
//  AppsSearchVC.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/12/28.
//

import AppData
import Domain
import UIKit

class AppsSearchVC: BaseViewController {
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!

    var data: DataSet = .empty
    var timer: Timer = .init()

    var text: String? {
        searchBar.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        registerAllCollectionViewCells(to: collectionView)
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        timer.invalidate()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier, segue.destination) {
        case let ("showAppDetails", vc as AppDetailsVC):
            guard let appDetails = sender as? AppDetails else { break }
            vc.data.id = String(appDetails.id)
        default: break
        }
    }

    func fetchSearchResults() {
        guard let text else { return }

        GetSearchResults(term: text).execute(in: .background).then(in: .main) { [weak self] searchResults in
            self?.data.resultApps = searchResults
            self?.collectionView.reloadData()
        }
    }
}

extension AppsSearchVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //
    // MARK: UICollectionViewDataSource
    //

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.resultApps?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = AppsSearchResultCell.dequeue(from: collectionView, for: indexPath, with: data.resultApps?[indexPath.item])
        return cell
    }

    //
    // MARK: UICollectionViewDelegate
    //

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showAppDetails", sender: data.resultApps?[indexPath.item])
    }

    //
    // MARK: UICollectionViewDelegateFlowLayout
    //

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return AppsSearchResultCell.estimatedSize(with: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 20, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        40
    }
}

extension AppsSearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            self.data.resultApps?.removeAll()
            self.fetchSearchResults()
            self.timer.invalidate()
        }
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text?.removeAll()
        searchBar.resignFirstResponder()
    }
}

extension AppsSearchVC {
    struct DataSet {
        var resultApps: [AppDetails]?
        static var empty: DataSet = .init()
    }
}

extension AppsSearchVC: CollectionViewRegister {
    var cellTypes: [UICollectionViewCell.Type] {
        [
            AppsSearchResultCell.self,
        ]
    }
}

extension AppsSearchVC: ScrollableToTop {
    var scrollableView: Any? {
        collectionView
    }
}
