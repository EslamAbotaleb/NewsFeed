//
//  HeaderCollectionReusableView.swift
//  NewsFeed
//
//  Created by Eslam Abotaleb on 31/05/2022.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var headerLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var title: String? {
        didSet {
            headerLbl.text = title
        }
    }
    
}
