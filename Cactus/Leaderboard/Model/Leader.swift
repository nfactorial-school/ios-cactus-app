//
//  Leader.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 8/1/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import Foundation

class Leader: Decodable {
    let name: String
    let about: String
    let image: String
    let statistics: LeaderStatistics
}
