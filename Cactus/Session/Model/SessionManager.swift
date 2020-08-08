//
//  SessionManagerDelegate.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 7/29/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import Foundation

protocol SessionManagerDelegate: AnyObject {
    func sessionDidStart(session: Session)
    func sessionTimeLeftChanged(session: Session, secondsLeft: Int)
    func sessionDidEnd(session: Session)
    func sessionDidCancel()
}

class SessionManager {
    weak var delegate: SessionManagerDelegate?
    
    var sessionTimer: CountdownTimer?
    
    init(delegate: SessionManagerDelegate) {
        self.delegate = delegate
    }
    
    func startSession(session: Session) {
        sessionTimer = CountdownTimer(durationInSeconds: session.durationInSeconds) { [weak self] secondsLeft in
            if secondsLeft == 0 {
                SessionsStorage.shared.addSession(session)
//                Balance.shared.addCoins(session.coinsCount)
                self?.delegate?.sessionDidEnd(session: session)
            } else {
                self?.delegate?.sessionTimeLeftChanged(session: session, secondsLeft: secondsLeft)
            }
        }
        
        sessionTimer?.start()
        delegate?.sessionDidStart(session: session)
    }
    
    func stopSession() {
        sessionTimer?.stop()
        delegate?.sessionDidCancel()
    }
}
