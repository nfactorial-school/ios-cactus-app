//
//  SessionsStorage.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 8/1/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import Foundation

class SessionsStorage {
    static let shared = SessionsStorage()
    
    var sessions = [Session]()
    
    func addSession(_ session: Session) {
        sessions.append(session)
    }
}
