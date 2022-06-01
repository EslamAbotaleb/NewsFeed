//
//  NewsFeedViewController.swift
//  NewsFeed
//
//  Created by Eslam Abotaleb on 31/05/2022.
//

import UIKit

class NewsFeedViewController: UIViewController {

    @IBOutlet weak var newsCollectionView: UICollectionView!
    

     private var NewsFeedDataSource: UICollectionViewDiffableDataSource<NewsFeedSection,Article>?
     var newsFeedVM: NewsFeedViewModel?
     var articleList: [Article] = [Article]()
     var newsFeedCoreDataModel = [News]()
     let persistence = PersistanceService.shared
     var stockSticker: StockTicker?

     public enum NewsFeedSection: String, CaseIterable {
        case stock = "Stocks"
        case latestNews = "Latest News"
        case moreNews = "More News"
     }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        newsCollectionView.dataSource = self
        newsCollectionView.delegate = self
        registerCells()
        newsCollectionView.collectionViewLayout = setupCollectionViewLayout()
        
        newsFeedVM = NewsFeedViewModel()

       
        loadDataBasedOnConnectionType()
        loadFromCSV()
    }
    
    func loadDataBasedOnConnectionType() {
        if (Reachability.isConnectedToNetwork()) {
            newsFeedVM?.displayNewsFeed(completion: { [weak self] news in
                     if news != nil {
                         print(news?.status ?? "")

                         self?.articleList = (news?.articles)!
                         DispatchQueue.main.async {
                             self?.newsCollectionView.reloadData()
                         }
                     }
                 })
                } else {
                    loadNewsFeedFromCoreData()
                }
    }
    
    func loadNewsFeedFromCoreData() {
        
            persistence.fetch(News.self) { [weak self] (newsFeed) in
               
                self?.newsFeedCoreDataModel = newsFeed
                
                DispatchQueue.main.async {
                    self?.newsCollectionView.reloadData()
                }
            }
    }
    
    
    func loadFromCSV() {
        //csv
        newsFeedVM?.loadCSV(completion: { [weak self] stock in
            self?.stockSticker = stock
            DispatchQueue.main.async {
                self?.newsCollectionView.reloadData()
            }
        })
    }
}


extension NewsFeedViewController {
    
    func registerCells() {
        newsCollectionView.register(UINib(nibName: "StockCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: StockCollectionViewCell.reuseIdentifier)
        
        newsCollectionView.register(UINib(nibName: "MoreNewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MoreNewsCollectionViewCell.reuseIdentifier)

        newsCollectionView.register(UINib(nibName: "LatestNewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: LatestNewsCollectionViewCell.reuseIdentifier)

        newsCollectionView.register(UINib(nibName: "HeaderCollectionReusableView", bundle: nil),
                                    forSupplementaryViewOfKind:"header",
                                    withReuseIdentifier: "HeaderCollectionReusableView")
        
        DispatchQueue.main.async {
            self.newsCollectionView.reloadData()
        }
       
    }

}



