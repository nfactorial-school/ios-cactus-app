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
        for i in 0...20 {
            let session1 = Session(durationInSeconds: 10 * (i + 1), startDate: session.startDate)
            sessions.append(session1)
        }
    }
}
