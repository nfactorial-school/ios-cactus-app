//
//  LearnViewController.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 8/2/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import UIKit

class LearnViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet var collectionView: UICollectionView!
    
    let articlesStorage = ArticlesStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Learn"
        collectionView.collectionViewLayout = layoutForCollectionView()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articlesStorage.articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "article_cell", for: indexPath) as! ArticleCollectionViewCell
        
        let article = articlesStorage.articles[indexPath.row]
        cell.configure(with: article)
        
        return cell
    }
    
    func layoutForCollectionView() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(279))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(279))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}
