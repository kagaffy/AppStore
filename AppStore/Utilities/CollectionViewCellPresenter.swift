//
//  CollectionViewCellPresenter.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/09/13.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import UIKit

protocol CollectionViewCellPresenter: AnyObject {
    associatedtype T

    var data: T? { get set }
    static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath, with data: T?) -> Self
    func apply(with data: T?)
}

extension CollectionViewCellPresenter where Self: UICollectionViewCell {
    static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath, with data: T?) -> Self {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: self), for: indexPath) as! Self
        cell.data = data
        cell.apply(with: data)
        return cell
    }
}
