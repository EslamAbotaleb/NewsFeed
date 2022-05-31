//
//  Resource.swift
//  NewsFeed
//
//  Created by Eslam Abotaleb on 31/05/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
struct Resource<T: Decodable> {
    let url: URL
}

extension URLRequest {
    static func load<T>(resource: Resource<T>) -> Observable<T> {
        
            return Observable<T>.create { observer in
                
                let request =  AF.request(resource.url).responseDecodable { (response: DataResponse<T, AFError>) in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
                
                return Disposables.create {
                    request.cancel()
                }
            }
        }
    
    
}
