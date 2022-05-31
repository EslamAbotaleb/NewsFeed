//
//  NewsFeedViewModel.swift
//  NewsFeed
//
//  Created by Eslam Abotaleb on 31/05/2022.
//

import Foundation
import RxSwift
import RxCocoa


final class NewsFeedViewModel {
    
    func displayNewsFeed(completion: @escaping(NewsFeed?) -> ()){
        
        let resource = Resource<NewsFeed>(url: URL(string: ConstantURL.baseUrl)!)
        
       _  = URLRequest.load(resource: resource)
            .subscribe { news in
                if news.element?.articles != nil {
                    completion(news.element)
                } else {
                    completion(nil)
                }
            }

    }
    
}

