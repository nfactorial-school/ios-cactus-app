//
//  LeaderboardResponse.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 8/5/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import Foundation

class LeaderboardResponse: Decodable {
    let users: [Leader]
}
