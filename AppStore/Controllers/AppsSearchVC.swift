//
//  AppsSearchVC.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/12/28.
//

import Combine
import Presentation
import UIKit

class AppsSearchVC: BaseViewController {
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!

    private lazy var viewModel = CompositionRoot.makeAppsSearchViewModel()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        registerAllCollectionViewCells(to: collectionView)
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationController?.navigationBar.isHidden = true
        bindViewModel()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier, segue.destination) {
        case let ("showAppDetails", vc as AppDetailsVC):
            guard let result = sender as? AppsSearchResultModel else { break }
            vc.appID = String(result.id)
        default: break
        }
    }

    private func bindViewModel() {
        viewModel.$results
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension AppsSearchVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.results.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = AppsSearchResultCell.dequeue(from: collectionView, for: indexPath, with: viewModel.results[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showAppDetails", sender: viewModel.results[indexPath.item])
    }

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
        viewModel.searchTextDidChange(searchText)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text?.removeAll()
        searchBar.resignFirstResponder()
        viewModel.clearResults()
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
