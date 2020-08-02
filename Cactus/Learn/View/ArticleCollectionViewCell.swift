//
//  ArticleCollectionViewCell.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 8/2/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import UIKit

class ArticleCollectionViewCell: UICollectionViewCell {
    @IBOutlet var cardView: UIView!
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        
        cardView.layer.cornerRadius = 16
        cardView.layer.masksToBounds = true
        
        thumbnailImageView.layer.cornerRadius = 16
        thumbnailImageView.layer.masksToBounds = true
    }
    
    func configure(with article: Article) {
        self.titleLabel.text = article.title
        self.subtitleLabel.text = article.subtitle
    }
}
