//
//  extension + CollectionDataSourceAndDelegate.swift
//  NewsFeed
//
//  Created by Eslam Abotaleb on 31/05/2022.
//

import UIKit


extension NewsFeedViewController:UICollectionViewDataSource, UICollectionViewDelegate {
 
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
            let stockPrice = stockSticker!.price[indexPath.row]
            let stockName = stockSticker!.stock[indexPath.row]
            cell.configure(stockName,stockPrice)
            return cell
            
        case .latestNews:
            
            guard let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: LatestNewsCollectionViewCell.reuseIdentifier, for: indexPath) as? LatestNewsCollectionViewCell else {
                fatalError("Not found stock cell")
            }
            let slicedLatestNewsArticle = self.articleList[0...5]
            let article = Array(slicedLatestNewsArticle)[indexPath.row]
            cell.configure(article)
            return cell
            
        case .moreNews:
            
            guard let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: MoreNewsCollectionViewCell.reuseIdentifier, for: indexPath) as? MoreNewsCollectionViewCell else {
                fatalError("Not found stock cell")
            }
            if (Reachability.isConnectedToNetwork()) {
                let slicedMoreNewsArticle = self.articleList[0...9]
                let article = Array(slicedMoreNewsArticle)[indexPath.row]
                cell.configure(article)
            } else {
                let slicedMoreNewsArticle = self.newsFeedCoreDataModel[0...9]
                let article = Array(slicedMoreNewsArticle)[indexPath.row]
                cell.titleNews.text = article.titleNews
                cell.descriptionLbl.text = article.descriptionNews
                cell.imgNews.imageFromURL(urlString: article.image ?? "")
            }
            return cell
            
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            
            return self.stockSticker!.price.count
        case 1:
            let articles = Array(self.articleList)
            return articles.slice(size: 15).count - 1
        case 2 :
            if (Reachability.isConnectedToNetwork()) {
                let sortedArticleByDate = articleList.sorted(by: {  $0.publishedAt! > $1.publishedAt!} )
                return sortedArticleByDate.slice(size: 10).count - 1
            } else {
                return newsFeedCoreDataModel.slice(size: 10).count - 1
            }
        default: return 0
        }
    }
    
}
