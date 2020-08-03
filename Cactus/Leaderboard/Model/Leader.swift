//
//  Leader.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 8/1/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import Foundation

class Leader {
    let name: String
    let about: String
    let daysCount: Int
    let sessionsCount: Int
    let totalFocusTimeInMinutes: Int
    
    init(name: String, about: String, daysCount: Int, sessionsCount: Int, totalFocusTimeInMinutes: Int) {
        self.name = name
        self.about = about
        self.daysCount = daysCount
        self.sessionsCount = sessionsCount
        self.totalFocusTimeInMinutes = totalFocusTimeInMinutes
    }
}
