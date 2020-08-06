//
//  LeaderboardViewController.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 8/1/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    let refreshControl = UIRefreshControl()
    
    var leaders = [Leader]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Leaderboard"
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)
        
        loadInitial()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let leaderCell = tableView.dequeueReusableCell(withIdentifier: "leader_cell", for: indexPath) as! LeaderTableViewCell
        
        let leader = leaders[indexPath.row]
        leaderCell.configure(with: leader, position: indexPath.row + 1)
        
        return leaderCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == leaders.count - 2 {
            loadMore()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let leaderVC = segue.destination as? LeaderViewController {
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            let selectedLeader = leaders[selectedIndexPath.row]
            leaderVC.leader = selectedLeader
        }
    }
    
    // MARK: - Loading
    
    func loadInitial() {
        activityIndicator.isHidden = false
        
        loadLeaders(offset: 0) { (leaders) in
            self.activityIndicator.isHidden = true
            
            guard let leaders = leaders else {
                return
            }
            
            self.leaders = leaders
            self.tableView.reloadData()
        }
    }
    
    @objc func reload() {
        isLoadingMore = false
        loadLeaders(offset: 0) { (leaders) in
            self.refreshControl.endRefreshing()
            
            guard let leaders = leaders else {
                return
            }
            
            self.leaders = leaders
            self.tableView.reloadData()
            
            self.lastOffset = 0
            self.allLeadersAreLoaded = false
        }
    }
    
    var lastOffset = 0
    var isLoadingMore = false
    var allLeadersAreLoaded = false
    
    func loadMore() {
        if allLeadersAreLoaded || isLoadingMore {
            return
        }

        isLoadingMore = true
        
        let offset = lastOffset + 10
        loadLeaders(offset: offset) { (newLeaders) in
            self.isLoadingMore = false
            
            guard let newLeaders = newLeaders else {
                return
            }
            
            self.lastOffset = offset

            if newLeaders.isEmpty {
                self.allLeadersAreLoaded = true
                return
            }
            
            let startIndex = self.leaders.count
            let endIndex = self.leaders.count + newLeaders.count - 1
            let indexPathsToAdd: [IndexPath] = (startIndex...endIndex).map { IndexPath(row: $0, section: 0) }
            
            self.leaders.append(contentsOf: newLeaders)
            
            self.tableView.insertRows(at: indexPathsToAdd, with: .automatic)
        }
    }
    
    var dataTask: URLSessionDataTask?
    
    func loadLeaders(offset: Int, completion: @escaping ([Leader]?) -> Void) {
        dataTask?.cancel()
        
        let url = URL(string: "https://ios-cactus-app.herokuapp.com/leaderboard?offset=\(offset)&limit=10")!
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            self.dataTask = nil
            
            if let data = data {
                do {
                    let leaderboardResponse = try JSONDecoder().decode(LeaderboardResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(leaderboardResponse.users)
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        self.showError(error)
                    }
                }
                
                return
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.showError(error)
                }
            }
            
            DispatchQueue.main.async {
                completion(nil)
            }
        }
        
        dataTask?.resume()
    }
    
    func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: false, completion: nil)
    }
}
