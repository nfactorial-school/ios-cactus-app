//
//  BreakViewController.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 7/28/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import UIKit

class BreakViewController: UIViewController {
    @IBOutlet var cactusImageView: UIImageView!
    @IBOutlet var takeABreakButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cactusImageView.layer.cornerRadius = cactusImageView.frame.width / 2
        cactusImageView.layer.masksToBounds = true
        
        takeABreakButton.layer.cornerRadius = 14
        takeABreakButton.layer.masksToBounds = true
    }
    
    @IBAction func didTapCloseButton() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapTakeABreakButton() {
        print("start break")
    }
}
