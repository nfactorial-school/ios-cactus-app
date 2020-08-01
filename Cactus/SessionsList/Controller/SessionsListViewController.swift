//
//  SessionsListViewController.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 8/1/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import UIKit

class SessionsListViewController: UIViewController, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Sessions"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SessionsStorage.shared.sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sessionCell = tableView.dequeueReusableCell(withIdentifier: "session_cell", for: indexPath) as! SessionsListTableViewCell
        
        let session = SessionsStorage.shared.sessions[indexPath.row]
        sessionCell.configure(with: session)
        
        return sessionCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            SessionsStorage.shared.sessions.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
