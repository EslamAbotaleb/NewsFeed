//
//  Article.swift
//  NewsFeed
//
//  Created by Eslam Abotaleb on 31/05/2022.
//

import Foundation
// MARK: - Article
struct Article: BaseModel {
    let source: Source
    let author: String?
    let title: String?
    let articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String

    enum CodingKeys: String, CodingKey {
        case source
        case articleDescription
        case publishedAt
        case author, title, url, urlToImage,content
    }
}
