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
        
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.masksToBounds = true

        title = leader.name
        
        cactusSessionsContainerView.layer.cornerRadius = 16
        cactusSessionsContainerView.layer.masksToBounds = true
        
        totalFocusTimeContainerView.layer.cornerRadius = 16
        totalFocusTimeContainerView.layer.masksToBounds = true
        
        daysWithCactusLabel.text = "\(leader.statistics.daysCount) days with Cactus"
        nameLabel.text = leader.name
        cactusSessionsCountLabel.text = "\(leader.statistics.sessionsCount)"
        totalFocusTimeLabel.text = "\(leader.statistics.totalFocusTimeInMinutes / 60)h \(leader.statistics.totalFocusTimeInMinutes % 60)m"
        aboutLabel.text = leader.about
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: leader.image))
    }
}
