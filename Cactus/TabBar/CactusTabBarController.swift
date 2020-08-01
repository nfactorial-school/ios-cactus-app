//
//  CactusTabBarController.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 8/1/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import UIKit

class CactusTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor(named: "secondaryColor")
        tabBar.unselectedItemTintColor = UIColor(named: "lightGrey")
    }
}
