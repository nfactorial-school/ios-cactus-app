//
//  BreakViewController.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 7/28/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import UIKit

class BreakViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, BreakManagerDelegate {
    @IBOutlet var cactusImageView: UIImageView!
    @IBOutlet var takeABreakButton: UIButton!
    
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var countdownLabel: UILabel!
    @IBOutlet var breakMessageLabel: UILabel!
    @IBOutlet var finishBreakButton: UIButton!
    
    var finishedSession: Session!
    
    lazy var breakManager = BreakManager(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cactusImageView.image = UIImage(named: finishedSession.cactus.imageName)
        
        takeABreakButton.layer.cornerRadius = 14
        takeABreakButton.layer.masksToBounds = true
        
        finishBreakButton.layer.cornerRadius = 14
        finishBreakButton.layer.masksToBounds = true
        finishBreakButton.layer.borderWidth = 1
        finishBreakButton.layer.borderColor = UIColor(named: "darkGrey")?.cgColor
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        cactusImageView.layer.cornerRadius = cactusImageView.frame.width / 2
        cactusImageView.layer.masksToBounds = true
    }
    @IBAction func didTapCloseButton() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapTakeABreakButton() {
        let selectedPickerRow = pickerView.selectedRow(inComponent: 0)
        let selectedDuration = durations[selectedPickerRow]
        
        // не превращаем минуты в секунды, чтобы было проще тестировать
        let aBreak = Break(durationInSeconds: selectedDuration)
        breakManager.startBreak(aBreak: aBreak)
    }
    
    @IBAction func didTapFinishBreakButton() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // PickerDataSource/Delegate
    
    let durations = [5, 10, 15, 20, 25, 30]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return durations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(durations[row]) mins"
    }
    
    // BreakManagerDelegate
    
    func breakDidStart(aBreak: Break) {
        showTimeLeft(secondsLeft: aBreak.durationInSeconds)
        
        pickerView.isHidden = true
        takeABreakButton.isHidden = true
        breakMessageLabel.isHidden = false
        countdownLabel.isHidden = false
        finishBreakButton.isHidden = false
    }
    
    func breakTimeLeftChanged(secondsLeft: Int) {
        showTimeLeft(secondsLeft: secondsLeft)
    }
    
    func breakDidEnd(aBreak: Break) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func breakDidCancel() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func showTimeLeft(secondsLeft: Int) {
        countdownLabel.text = String(format: "%02d:%02d", secondsLeft / 60, secondsLeft % 60)
    }
}
