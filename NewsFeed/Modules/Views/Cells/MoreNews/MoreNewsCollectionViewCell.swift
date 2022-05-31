//
//  MoreNewsCollectionViewCell.swift
//  NewsFeed
//
//  Created by Eslam Abotaleb on 31/05/2022.
//

import UIKit

class MoreNewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var dateNews: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(_ article: Article) {
        self.titleNews.text = article.title
        self.descriptionLbl.text = article.articleDescription
        let date = Date()
        self.dateNews.text = date.getFormattedDate(format: article.publishedAt ?? "")
        self.imgNews.imageFromURL(urlString: article.urlToImage ?? "")
        self.descriptionLbl.numberOfLines = 1
        self.titleNews.numberOfLines = 1

    }
}
