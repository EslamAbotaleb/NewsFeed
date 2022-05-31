//
//  NewsFeed.swift
//  NewsFeed
//
//  Created by Eslam Abotaleb on 31/05/2022.
//

import Foundation
// MARK: - NewsFeed
struct NewsFeed: BaseModel {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}
