//
//  UIImageView+Cache.swift
//  NewsFeed
//
//  Created by Eslam Abotaleb on 31/05/2022.
//


import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
   
//
//    func loadImage(url: URL) -> Observable<UIImage?> {
//        return Observable<UIImage?>.create { emitter in
//
//            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
//
//                guard let data = data else {
//                    emitter.onNext(nil)
//                    emitter.onCompleted()
//                    return
//                }
//
//                let image = UIImage(data: data)
//                emitter.onNext(image)
//                emitter.onCompleted()
//            }
//            task.resume()
//
//            return Disposables.create {
//                task.cancel()
//            }
//        }
//    }
     func imageFromURL(urlString: String) {

         let activityIndicator = UIActivityIndicatorView(style: .medium)
           activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
           activityIndicator.startAnimating()
           if self.image == nil{
               self.addSubview(activityIndicator)
           }

           URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in

               if error != nil {
                   print(error ?? "No Error")
                   return
               }
               DispatchQueue.main.async(execute: { () -> Void in
                   let image = UIImage(data: data!)
                   activityIndicator.removeFromSuperview()
                   self.image = image
               })

           }).resume()
       }
 
     
}
