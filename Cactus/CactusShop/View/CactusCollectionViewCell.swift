//
//  CactusCollectionViewCell.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 8/3/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import UIKit

class CactusCollectionViewCell: UICollectionViewCell {
    @IBOutlet var cardView: UIView!
    @IBOutlet var cactusImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        
        cardView.layer.cornerRadius = 16
        cardView.layer.masksToBounds = true
        
        cactusImageView.layer.cornerRadius = 16
        cactusImageView.layer.masksToBounds = true
    }

    func configure(with cactus: Cactus, isSelected: Bool) {
        cactusImageView.image = UIImage(named: cactus.imageName)
        cardView.backgroundColor = isSelected ? UIColor(named: "primaryColor") : UIColor(named: "secondaryColor2")
    }
}
