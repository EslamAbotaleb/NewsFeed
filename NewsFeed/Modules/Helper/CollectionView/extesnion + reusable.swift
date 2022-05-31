//
//  extesnion + reusable.swift
//  NewsFeed
//
//  Created by Eslam Abotaleb on 31/05/2022.
//

import Foundation
extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
