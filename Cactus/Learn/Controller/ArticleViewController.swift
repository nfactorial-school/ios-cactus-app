//
//  ArticleViewController.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 8/4/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import UIKit

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
        
        title = article.title

        titleLabel.text = article.title
        textLabel.text = article.text
        authorNameLabel.text = article.author.name
        authorSubtitleLabel.text = article.author.subtitle
    }
}
