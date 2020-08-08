//
//  BreakManager.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 7/29/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import Foundation

protocol BreakManagerDelegate: AnyObject {
    func breakDidStart(aBreak: Break)
    func breakTimeLeftChanged(secondsLeft: Int)
    func breakDidEnd(aBreak: Break)
    func breakDidCancel()
}

class BreakManager {
    weak var delegate: BreakManagerDelegate?
    
    var breakTimer: CountdownTimer?
    
    init(delegate: BreakManagerDelegate) {
        self.delegate = delegate
    }
    
    func startBreak(aBreak: Break) {
        breakTimer = CountdownTimer(durationInSeconds: aBreak.durationInSeconds) { [weak self] secondsLeft in
            if secondsLeft == 0 {
                self?.delegate?.breakDidEnd(aBreak: aBreak)
            } else {
                self?.delegate?.breakTimeLeftChanged(secondsLeft: secondsLeft)
            }
        }
        
        breakTimer?.start()
        delegate?.breakDidStart(aBreak: aBreak)
    }
    
    func cancelBreak() {
        breakTimer?.stop()
        delegate?.breakDidCancel()
    }
}
