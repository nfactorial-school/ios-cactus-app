//
//  LeaderTableViewCell.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 8/1/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import UIKit

class LeaderTableViewCell: UITableViewCell {
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var hoursCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
    }
    
    func configure(with leader: Leader, position: Int) {
        positionLabel.text = "\(position)"
        nameLabel.text = leader.name
        hoursCountLabel.text = "\(leader.hoursCount) hr."
        
        if position <= 3 {
            positionLabel.textColor = UIColor(named: "secondaryColor")
        } else {
            positionLabel.textColor = UIColor(named: "grey")
        }
    }
}
