//
//  ArticleViewController.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 8/4/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
    
    @IBOutlet var authorImageView: UIImageView!
    @IBOutlet var authorNameLabel: UILabel!
    @IBOutlet var authorSubtitleLabel: UILabel!
    
    var article: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorImageView.layer.cornerRadius = authorImageView.frame.width / 2
        authorImageView.layer.masksToBounds = true
        
        title = article.title

        titleLabel.text = article.title
        textLabel.text = article.text
        authorNameLabel.text = article.author.name
        authorSubtitleLabel.text = article.author.subtitle
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: article.image))
        
        authorImageView.kf.indicatorType = .activity
        authorImageView.kf.setImage(with: URL(string: article.author.image))
    }
}
