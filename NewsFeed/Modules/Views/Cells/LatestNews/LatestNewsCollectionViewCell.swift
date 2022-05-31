//
//  LatestNewsCollectionViewCell.swift
//  NewsFeed
//
//  Created by Eslam Abotaleb on 31/05/2022.
//

import UIKit

class LatestNewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var titleNewsLbL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ article: Article) {
        self.titleNewsLbL.text = article.title
        self.imgNews.imageFromURL(urlString: article.urlToImage ?? "")
    }
}
