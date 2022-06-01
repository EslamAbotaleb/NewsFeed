//
//  StockSticker.swift
//  NewsFeed
//
//  Created by Eslam Abotaleb on 01/06/2022.
//

import Foundation
// MARK: - StockTicker
struct StockTicker: BaseModel {
    let price: [String]
    let stock: [Stock]

    enum CodingKeys: String, CodingKey {
        case price = "PRICE"
        case stock = "STOCK"
    }
}

enum Stock: String, Codable {
    case aapl = "AAPL"
    case acn = "ACN"
    case amd = "AMD"
    case ford = "FORD"
    case nio = "NIO"
    case nvda = "NVDA"
    case tesla = "TESLA"
}
