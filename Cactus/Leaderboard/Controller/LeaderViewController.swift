//
//  LeaderViewController.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 8/4/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import UIKit

class LeaderViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var daysWithCactusLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var cactusSessionsCountLabel: UILabel!
    @IBOutlet var totalFocusTimeLabel: UILabel!
    @IBOutlet var aboutLabel: UILabel!
    
    @IBOutlet var cactusSessionsContainerView: UIView!
    @IBOutlet var totalFocusTimeContainerView: UIView!
    
    var leader: Leader!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = leader.name
        
        cactusSessionsContainerView.layer.cornerRadius = 16
        cactusSessionsContainerView.layer.masksToBounds = true
        
        totalFocusTimeContainerView.layer.cornerRadius = 16
        totalFocusTimeContainerView.layer.masksToBounds = true
        
        daysWithCactusLabel.text = "\(leader.daysCount) days with Cactus"
        nameLabel.text = leader.name
        cactusSessionsCountLabel.text = "\(leader.sessionsCount)"
        totalFocusTimeLabel.text = "\(leader.totalFocusTimeInMinutes / 60)h \(leader.totalFocusTimeInMinutes % 60)m"
        aboutLabel.text = leader.about
    }
}
