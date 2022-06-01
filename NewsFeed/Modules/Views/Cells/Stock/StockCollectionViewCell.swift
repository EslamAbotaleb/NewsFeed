//
//  StockCollectionViewCell.swift
//  NewsFeed
//
//  Created by Eslam Abotaleb on 31/05/2022.
//

import UIKit

class StockCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var stockNameLbl: UILabel!
    @IBOutlet weak var stockView: UIView!
    @IBOutlet weak var priceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ stockName: Stock,_ price: String) {
        stockNameLbl.text = stockName.rawValue
        priceLbl.text = String(format: "%.2f",  Float(price)!) + " USD"
    }
}
