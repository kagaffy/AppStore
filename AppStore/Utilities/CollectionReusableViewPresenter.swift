//
//  CollectionReusableViewPresenter.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/12/03.
//

import UIKit

protocol CollectionReusableViewPresenter: AnyObject {
    associatedtype T

    var data: T? { get set }
    static func dequeue(from collectionView: UICollectionView, of kind: String, for indexPath: IndexPath, with data: T?) -> Self
    func apply(with data: T?)
}

extension CollectionReusableViewPresenter where Self: UICollectionReusableView {
    static func dequeue(from collectionView: UICollectionView, of kind: String, for indexPath: IndexPath, with data: T? = nil) -> Self {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: self), for: indexPath) as! Self
        cell.apply(with: data)
        return cell
    }
}
