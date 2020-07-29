//
//  SessionViewController.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 7/28/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import UIKit

class SessionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, SessionManagerDelegate {
    @IBOutlet var topLabel: UILabel!

    @IBOutlet var cactusImageView: UIImageView!
    
    @IBOutlet var plantButton: UIButton!
    @IBOutlet var pickerView: UIPickerView!
    
    @IBOutlet var countdownLabel: UILabel!
    @IBOutlet var giveUpButton: UIButton!
    
    @IBOutlet var cancelButton: UIButton!
    lazy var sessionManager = SessionManager(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cactusImageView.layer.cornerRadius = cactusImageView.frame.width / 2
        cactusImageView.layer.masksToBounds = true
        
        plantButton.layer.cornerRadius = 14
        plantButton.layer.masksToBounds = true
        
        giveUpButton.layer.cornerRadius = 14
        giveUpButton.layer.masksToBounds = true
        giveUpButton.layer.borderWidth = 1
        giveUpButton.layer.borderColor = UIColor(named: "darkGrey")?.cgColor
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    @IBAction func didTapPlantButton() {
        let selectedPickerRow = pickerView.selectedRow(inComponent: 0)
        let selectedDuration = durations[selectedPickerRow]
        
        // не превращаем минуты в секунды, чтобы было проще тестировать
        let session = Session(durationInSeconds: selectedDuration)
        sessionManager.startSession(session: session)
    }
    
    @IBAction func didTapCancelButton() {
        sessionManager.stopSession()
    }
    
    @IBAction func didTapGiveUpButton() {
        sessionManager.stopSession()
    }
    
    // PickerDataSource/Delegate
    
    let durations = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return durations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(durations[row]) mins"
    }
    
    // SessionManagerDelegate
        
    func sessionDidStart(session: Session) {
        showTimeLeft(secondsLeft: session.durationInSeconds)
        
        pickerView.isHidden = true
        plantButton.isHidden = true
        countdownLabel.isHidden = false
        cancelButton.isHidden = false
        
        updateCancelButtonTitle(secondsLeft: 10)
    }
    
    func sessionTimeLeftChanged(session: Session, secondsLeft: Int) {
        showTimeLeft(secondsLeft: secondsLeft)
        
        let secondsPassed = session.durationInSeconds - secondsLeft
        if secondsPassed < 10 {
            updateCancelButtonTitle(secondsLeft: 10 - secondsPassed)
        } else if secondsPassed == 10 {
            cancelButton.isHidden = true
            giveUpButton.isHidden = false
        }
    }
    
    func showTimeLeft(secondsLeft: Int) {
        countdownLabel.text = String(format: "%02d:%02d", secondsLeft / 60, secondsLeft % 60)
    }
    
    func sessionDidEnd(session: Session) {
        topLabel.text = "You've planted a cactus!"
        performSegue(withIdentifier: "showBreak", sender: nil)
        
        pickerView.isHidden = false
        plantButton.isHidden = false
        countdownLabel.isHidden = true
        giveUpButton.isHidden = true
        cancelButton.isHidden = true
    }
    
    func sessionDidCancel() {
        pickerView.isHidden = false
        plantButton.isHidden = false
        countdownLabel.isHidden = true
        giveUpButton.isHidden = true
        cancelButton.isHidden = true
    }
    
    func updateCancelButtonTitle(secondsLeft: Int) {
        let title = "Cancel (\(secondsLeft))"
        
        UIView.performWithoutAnimation {
            cancelButton.setTitle(title, for: .normal)
            cancelButton.layoutIfNeeded()
        }
    }
}

