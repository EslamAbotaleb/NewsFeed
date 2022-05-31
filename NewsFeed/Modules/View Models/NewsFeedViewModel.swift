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
                    SVProgressHUD.dismiss()
                   
                } else {
                    completion(nil)
                }
            }
    }
    
}

