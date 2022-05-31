//
//  extension + CollectionDataSourceAndDelegate.swift
//  NewsFeed
//
//  Created by Eslam Abotaleb on 31/05/2022.
//

import UIKit


extension NewsFeedViewController:UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 4
        case 1: return 5
        case 2 : return 6
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let viewHeader = newsCollectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as? HeaderCollectionReusableView else {
          return UICollectionReusableView()
        }
        
        viewHeader.title = NewsFeedSection.allCases[indexPath.section].rawValue
        return viewHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = NewsFeedSection.allCases[indexPath.section]

        switch sectionType {

        case .stock:
            guard let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: StockCollectionViewCell.reuseIdentifier, for: indexPath) as? StockCollectionViewCell else {
                fatalError("Not found stock cell")
            }
            cell.backgroundColor = .red
            return cell
        case .latestNews:
            guard let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: LatestNewsCollectionViewCell.reuseIdentifier, for: indexPath) as? LatestNewsCollectionViewCell else {
                fatalError("Not found stock cell")
            }
            cell.backgroundColor = .orange
            return cell
        case .moreNews:
            guard let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: MoreNewsCollectionViewCell.reuseIdentifier, for: indexPath) as? MoreNewsCollectionViewCell else {
                fatalError("Not found stock cell")
            }
            
//            cell.backgroundColor = .gray
            return cell
        }
    }

}
