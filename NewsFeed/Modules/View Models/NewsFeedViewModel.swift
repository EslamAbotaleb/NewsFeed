//
//  NewsFeedViewModel.swift
//  NewsFeed
//
//  Created by Eslam Abotaleb on 31/05/2022.
//

import Foundation
import RxSwift
import RxCocoa
import SVProgressHUD

final class NewsFeedViewModel {
    
    func displayNewsFeed(completion: @escaping(NewsFeed?) -> ()){
        SVProgressHUD.show(withStatus: "Loading...")
        let resource = Resource<NewsFeed>(url: URL(string: ConstantURL.baseUrl)!)
       _  = URLRequest.load(resource: resource)
            .subscribe { news in
                if news.element?.articles != nil {
                    completion(news.element)
                    
                    self.saveNewsFeedFromServerIntoCoreData(completion: { articlesNews in
                                          print(articlesNews)
                                      }, PersistanceService.shared)
                    
                    
                    SVProgressHUD.dismiss()
                } else {
                    completion(nil)
                }
            }
    }
    
    //save into core data
       func saveNewsFeedFromServerIntoCoreData(completion: @escaping([News]?) -> (), _ persistance: PersistanceService) {
           let urlPath = ConstantURL.baseUrl
           
           guard let url = URL(string: urlPath) else { return }
           URLSession.shared.dataTask(with: url) { (data, response, error) in
               guard error == nil else { return }
               guard let data = data else { return }
               do {
                   let articlesNews = try JSONDecoder().decode(NewsFeed.self, from: data)
                   
                   let fetchArticles = articlesNews.articles
                   let resultArticlesCoreDataModel: [News] = fetchArticles!.compactMap {
                       
                       let articleModel = News(context: persistance.context)
                       
                       articleModel.image = $0.urlToImage
                       articleModel.titleNews = $0.title
                       articleModel.descriptionNews = $0.articleDescription
                       
                       return articleModel
                   }

                   completion(resultArticlesCoreDataModel)
                   
                   DispatchQueue.main.async {
                       persistance.save()
                   }
                   
               } catch let error {
                   print(error)
               }
           }.resume()
           
       }
    
    //csv
    func loadCSV(completion: @escaping(StockTicker?) -> ()) {
        do {
            let csv: CSV = try CSV(url: URL(string: ConstantURL.stockCSV)!)
               let encoder = JSONEncoder()
               if let jsonData = try? encoder.encode(csv.namedColumns) {
                 let stockSticker = try JSONDecoder().decode(StockTicker.self, from: jsonData)
                   completion(stockSticker)
               }
           } catch {
               print("errorerror\(error)")

           }
    }
}

