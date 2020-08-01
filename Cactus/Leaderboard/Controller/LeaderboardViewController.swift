//
//  LeaderboardViewController.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 8/1/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    
    let leadersStorage = LeadersStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Leaderboard"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leadersStorage.leaders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let leaderCell = tableView.dequeueReusableCell(withIdentifier: "leader_cell", for: indexPath) as! LeaderTableViewCell
        
        let leader = leadersStorage.leaders[indexPath.row]
        leaderCell.configure(with: leader, position: indexPath.row + 1)
        
        return leaderCell
    }
}
