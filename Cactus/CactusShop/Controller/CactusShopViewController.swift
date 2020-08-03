//
//  CactusShopViewController.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 8/2/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import UIKit

class CactusShopViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.collectionViewLayout = layoutForCollectionView()
    }
    
    @IBAction func didTapCloseButton() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CactusesStorage.shared.cactuses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cactus_cell", for: indexPath) as! CactusCollectionViewCell
        
        let cactus = CactusesStorage.shared.cactuses[indexPath.row]
        cell.configure(with: cactus, isSelected: CactusesStorage.shared.isCactusSelected(cactus))
        
        return cell
    }
    
    func layoutForCollectionView() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(13)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 23
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCactus = CactusesStorage.shared.cactuses[indexPath.row]
        CactusesStorage.shared.selectCactus(selectedCactus)
        
        collectionView.reloadData()
    }
}
