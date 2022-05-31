//
//  exetension  for  collectionviewcell.swift
//  NewsFeed
//
//  Created by Eslam Abotaleb on 31/05/2022.
//

import UIKit


extension UICollectionViewCell: ReusableView {}


extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        
        return cell
    }
}
