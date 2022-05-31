//
//  extenstion + Array.swift
//  NewsFeed
//
//  Created by Eslam Abotaleb on 31/05/2022.
//

import Foundation
extension Array {
   func slice(size: Int) -> [[Element]] {
      (0...(count / size)).map{Array(self[($0 * size)..<(Swift.min($0 * size + size, count))])}
   }
}
