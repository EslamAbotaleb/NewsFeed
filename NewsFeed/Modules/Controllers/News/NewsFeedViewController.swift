//
//  NewsFeedViewController.swift
//  NewsFeed
//
//  Created by Eslam Abotaleb on 31/05/2022.
//

import UIKit
import SVProgressHUD

class NewsFeedViewController: UIViewController {

    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    public enum NewsFeedSection: String, CaseIterable {
        case stock = "Stocks"
        case latestNews = "Latest News"
        case moreNews = "More News"
     }
     
     private var NewsFeedDataSource: UICollectionViewDiffableDataSource<NewsFeedSection,Article>?
     var newsFeedVM: NewsFeedViewModel?
     var articleList: [Article] = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsCollectionView.dataSource = self
        newsCollectionView.delegate = self
        registerCells()
        newsCollectionView.collectionViewLayout = setupCollectionViewLayout()
        
        newsFeedVM = NewsFeedViewModel()

        newsFeedVM?.displayNewsFeed(completion: { [weak self] news in
                 if news != nil {
                     print(news?.status ?? "")
                     self?.articleList = (news?.articles)!
                     DispatchQueue.main.async {
                         self?.newsCollectionView.reloadData()
                     }
                 }
             })
    }
    
    
 
    func generateSnapshot() -> NSDiffableDataSourceSnapshot<NewsFeedSection, Article> {
       var snapshot = NSDiffableDataSourceSnapshot<NewsFeedSection, Article>()
       
       snapshot.appendSections([NewsFeedSection.stock])
       snapshot.appendSections([NewsFeedSection.latestNews])
       snapshot.appendSections([NewsFeedSection.moreNews])

       return snapshot
    }
    
    
}

//Helper
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
    
    
    
    func setupCollectionViewLayout() -> UICollectionViewLayout {
       let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
          
          let movieSections = NewsFeedSection.allCases[sectionIndex]
          switch movieSections {
          case .stock: return self.createStockSection()
          case .latestNews: return self.createLatestNewsSection()
          case .moreNews: return self.createMoreNewsSection()

          }
       }
       return layout
    }
    
 
}



