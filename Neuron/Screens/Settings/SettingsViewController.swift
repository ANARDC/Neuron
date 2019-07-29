//
//  SettingsViewController.swift
//  Neuron
//
//  Created by Anar on 21/07/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit
import PWSwitch

// MARK: - SettingsViewController Class

final class SettingsViewController: UIViewController {
    
    // MARK: - Main View IBOutlets
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var diaryLabel: UILabel!
    @IBOutlet weak var tasksLabel: UILabel!
    
    // MARK: - Setting Views IBOutlets
    @IBOutlet var settingsViews: [UIView]!
    @IBOutlet var settingsTitles: [UILabel]!
    @IBOutlet var settingsSubtitles: [UILabel]!
    @IBOutlet var switches: [PWSwitch]!
    
    
    // MARK: - FillingDiaryButtons
    @IBOutlet weak var firstTimeFillingDiaryButton: UIButton!
    @IBOutlet weak var secondTimeFillingDiaryButton: UIButton!
    @IBOutlet weak var thirdTimeFillingDiaryButton: UIButton!
    @IBOutlet weak var fourthTimeFillingDiaryButton: UIButton!
    
    // MARK: - FrequencyTaskButtons
    @IBOutlet weak var dailyFrequencyTaskButton: UIButton!
    @IBOutlet weak var weeklyFrequencyTaskButton: UIButton!
    @IBOutlet weak var monthlyFrequencyTaskButton: UIButton!
    
    // MARK: - Buttons Background IBOutlets
    @IBOutlet weak var timeBackgroundView: UIView!
    @IBOutlet weak var frequencyBackgroundView: UIView!
    
    // MARK: - Constraints
    @IBOutlet weak var diaryFillingViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tasksSettingViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Class Properties
    let animationsDuration = 0.4
}

// MARK: - SettingsViewController Life Cycle

extension SettingsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        BarDesign().makeNavigationBarTranslucent(navigationController: self.navigationController)
        notificationLabelViewing()
        diaryLabelViewing()
        tasksLabelViewing()
        settingsViewsViewing()
        settingsTitlesViewing()
        settingsSubtitlesViewing()
        switchesViewing()
        selectButtonsViewing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Switches Actions

extension SettingsViewController {
    
    // MARK: - First Switch
    @IBAction func firstSwitchValueChanged(_ sender: PWSwitch) {
        switch sender.on {
        case true:
            sender.layer.borderColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37).cgColor
            sender.shadowOpacity = 1
        default:
            sender.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
            sender.shadowOpacity = 0
        }
        
        [firstTimeFillingDiaryButton,
         secondTimeFillingDiaryButton,
         thirdTimeFillingDiaryButton,
         fourthTimeFillingDiaryButton].forEach { (button) in
            button?.isHidden = !button!.isHidden
        }
        diaryFillingViewHeightConstraint.constant = diaryFillingViewHeightConstraint.constant == 100 ? 55 : 100
        timeBackgroundView.isHidden = !timeBackgroundView.isHidden
    }
    
    @IBAction func firstSwitchTouchDown(_ sender: PWSwitch) {
        baseSwitchTouchDown(sender)
    }
    
    @IBAction func firstSwitchTouchUpInside(_ sender: PWSwitch) {
        baseSwitchTouchUpInside(sender)
    }
    
    @IBAction func firstSwitchTouchUpOutside(_ sender: PWSwitch) {
        baseSwitchTouchUpOutside(sender)
    }
    
    @IBAction func firstSwitchTouchDragExit(_ sender: PWSwitch) {
        baseSwitchDragExit(sender)
    }
    
    // MARK: - Second Switch
    @IBAction func secondSwitchValueChanged(_ sender: PWSwitch) {
        if sender.on {
            sender.layer.borderColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37).cgColor
            sender.shadowOpacity = 1
        } else {
            sender.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
            sender.shadowOpacity = 0
        }
        
        [dailyFrequencyTaskButton,
         weeklyFrequencyTaskButton,
         monthlyFrequencyTaskButton].forEach { (button) in
            button?.isHidden = !button!.isHidden
        }
        tasksSettingViewHeightConstraint.constant = tasksSettingViewHeightConstraint.constant == 100 ? 55 : 100
        frequencyBackgroundView.isHidden = !frequencyBackgroundView.isHidden
    }
    
    @IBAction func secondSwitchTouchDown(_ sender: PWSwitch) {
        baseSwitchTouchDown(sender)
    }
    
    @IBAction func secondSwitchTouchUpInside(_ sender: PWSwitch) {
        baseSwitchTouchUpInside(sender)
    }
    
    @IBAction func secondSwitchTouchUpOutside(_ sender: PWSwitch) {
        baseSwitchTouchUpOutside(sender)
    }
    
    @IBAction func secondSwitchDragExit(_ sender: PWSwitch) {
        baseSwitchDragExit(sender)
    }
    
    // MARK: - Base Switch Actions
    func baseSwitchTouchDown(_ sender: PWSwitch) {
        sender.layer.borderColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37).cgColor
        if sender.on {
            UIView.animate(withDuration: animationsDuration) {
                sender.shadowOpacity = 0
            }
        } else {
            UIView.animate(withDuration: animationsDuration) {
                sender.shadowOpacity = 1
            }
        }
    }
    
    func baseSwitchTouchUpInside(_ sender: PWSwitch) {
        switch sender.on {
        case true:
            sender.layer.borderColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37).cgColor
            UIView.animate(withDuration: animationsDuration) {
                sender.shadowOpacity = 1
            }
        case false:
            if sender.layer.borderColor == UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37).cgColor {
                sender.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
            }
            UIView.animate(withDuration: animationsDuration) {
                sender.shadowOpacity = 0
            }
        }
    }
    
    func baseSwitchTouchUpOutside(_ sender: PWSwitch) {
        switch sender.on {
        case true:
            sender.layer.borderColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37).cgColor
            UIView.animate(withDuration: animationsDuration) {
                sender.shadowOpacity = 1
            }
        case false:
            if sender.layer.borderColor == UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37).cgColor {
                sender.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
            }
            UIView.animate(withDuration: animationsDuration) {
                sender.shadowOpacity = 0
            }
        }
    }
    
    func baseSwitchDragExit(_ sender: PWSwitch) {
        if sender.on {
            sender.layer.borderColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37).cgColor
        }
    }
}

// MARK: - Selecting Buttons Actions

extension SettingsViewController {
    @IBAction func firstTimeFillingDiaryButton(_ sender: UIButton) {
    }
    
    @IBAction func secondTimeFillingDiaryButton(_ sender: UIButton) {
    }
    
    @IBAction func thirdTimeFillingDiaryButton(_ sender: UIButton) {
    }
    
    @IBAction func fourthTimeFillingDiaryButton(_ sender: UIButton) {
    }
    
    @IBAction func dailyFrequencyTaskButton(_ sender: UIButton) {
    }
    
    @IBAction func weeklyFrequencyTaskButton(_ sender: UIButton) {
    }
    
    @IBAction func monthlyFrequencyTaskButton(_ sender: UIButton) {
    }
}

// MARK: - Viewing Functions

extension SettingsViewController {
    
    // MARK: - Main View
    func notificationLabelViewing() {
        notificationLabel.textColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 0.9)
    }
    
    func diaryLabelViewing() {
        diaryLabel.textColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 0.5)
    }
    
    func tasksLabelViewing() {
        tasksLabel.textColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 0.5)
    }
    
    // MARK: - Settings Views Filling View
    func settingsViewsViewing() {
        settingsViews.forEach { (view) in
            view.shadowColor = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
            view.shadowOpacity = 1
            view.shadowRadius = 14
            view.shadowOffset = CGSize(width: 0, height: 11)
            view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            view.layer.cornerRadius = 5
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
        }
        
        [firstTimeFillingDiaryButton,
         secondTimeFillingDiaryButton,
         thirdTimeFillingDiaryButton,
         fourthTimeFillingDiaryButton,
         dailyFrequencyTaskButton,
         weeklyFrequencyTaskButton,
         monthlyFrequencyTaskButton].forEach { (button) in
            button?.isHidden = true
        }
        
        diaryFillingViewHeightConstraint.constant = 55
        timeBackgroundView.isHidden = true
        tasksSettingViewHeightConstraint.constant = 55
        frequencyBackgroundView.isHidden = true
    }
    
    // MARK: - Settings Views Titles
    func settingsTitlesViewing() {
        settingsTitles.forEach { (title) in
            title.textColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 0.9)
        }
    }
    
    // MARK: - Settings Views Subtitles
    func settingsSubtitlesViewing() {
        settingsSubtitles.forEach { (subtitle) in
            subtitle.textColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 0.6)
        }
    }
    
    // MARK: - Settings Views Switches
    func switchesViewing() {
        switches.forEach { (switchElement) in
            switchElement.shadowColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37).cgColor
            switchElement.shadowOpacity = 0
            switchElement.shadowRadius = 5
            switchElement.shadowOffset = CGSize(width: 0, height: 5)
            
            switchElement.layer.cornerRadius = 18
            switchElement.layer.borderWidth = 1.5
            switchElement.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
            
            switchElement.layer.cornerRadius = 15.5
            switchElement.thumbCornerRadius = 5
            switchElement.thumbDiameter = 20
            
            switchElement.trackOnFillColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37)
            switchElement.trackOnBorderColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 1)
            switchElement.trackOffPushBorderColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37)
            
            switchElement.thumbOnBorderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            switchElement.thumbOffBorderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
            switchElement.thumbOnFillColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    // MARK: - Settings Views Select Buttons
    func selectButtonsViewing() {
        [firstTimeFillingDiaryButton,
         secondTimeFillingDiaryButton,
         thirdTimeFillingDiaryButton,
         fourthTimeFillingDiaryButton,
         dailyFrequencyTaskButton,
         weeklyFrequencyTaskButton,
         monthlyFrequencyTaskButton].forEach { (button) in
            button!.titleLabel?.minimumScaleFactor = 0.1
            button!.titleLabel?.numberOfLines = 1
            button!.titleLabel?.adjustsFontSizeToFitWidth = true
            button!.titleLabel?.textColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 0.9)
        }
    }
}
