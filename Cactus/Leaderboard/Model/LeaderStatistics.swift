//
//  LeaderStatistics.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 8/5/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import Foundation

class LeaderStatistics: Decodable {
    let daysCount: Int
    let sessionsCount: Int
    let totalFocusTimeInMinutes: Int
}
