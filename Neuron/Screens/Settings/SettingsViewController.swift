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
  var diaryFillingTimeSelectedBackgroundViewPosition = 0
  var tasksFillingTimeSelectedBackgroundViewPosition = 0

  let notificationsProcesses = NotificationsProcesses()
}

// MARK: - SettingsViewController Life Cycle

extension SettingsViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    BarDesign().makeNavigationBarTranslucent(self.navigationController)
    notificationLabelViewing()
    diaryLabelViewing()
    tasksLabelViewing()
    settingsViewsViewing()
    settingsTitlesViewing()
    settingsSubtitlesViewing()
    switchesViewing()
    selectButtonsViewing()
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

      notificationsProcesses.scheduleNotification(notificationType: "DiaryFillingNotificationID", hour: 22, minute: 30, frequency: nil)
    default:
      sender.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
      sender.shadowOpacity = 0

      notificationsProcesses.removeNotification(notificationType: "DiaryFillingNotificationID")
    }

    [firstTimeFillingDiaryButton,
     secondTimeFillingDiaryButton,
     thirdTimeFillingDiaryButton,
     fourthTimeFillingDiaryButton].forEach { (button) in
      button?.isHidden = !button!.isHidden
    }

    diaryFillingViewHeightConstraint.constant = diaryFillingViewHeightConstraint.constant == 100 ? 55 : 100
    timeBackgroundView.isHidden = !timeBackgroundView.isHidden

    selectButtonsBackgroundViewing(for: timeBackgroundView)
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

      notificationsProcesses.tasksNotificationsStatus = "daily"
    } else {
      sender.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
      sender.shadowOpacity = 0

      notificationsProcesses.tasksNotificationsStatus = "NONE"
    }

    [dailyFrequencyTaskButton,
     weeklyFrequencyTaskButton,
     monthlyFrequencyTaskButton].forEach { (button) in
      button?.isHidden = !button!.isHidden
    }

    tasksSettingViewHeightConstraint.constant = tasksSettingViewHeightConstraint.constant == 100 ? 55 : 100
    frequencyBackgroundView.isHidden = !frequencyBackgroundView.isHidden

    selectButtonsBackgroundViewing(for: frequencyBackgroundView)
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
    if sender.on {
      let animation = CABasicAnimation(keyPath: "shadowOpacity")
      animation.fromValue = sender.shadowOpacity
      animation.toValue = 0
      animation.duration = animationsDuration
      sender.layer.add(animation, forKey: animation.keyPath)
      sender.shadowOpacity = 0
    } else {
      sender.layer.borderColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37).cgColor
      let animation = CABasicAnimation(keyPath: "shadowOpacity")
      animation.fromValue = sender.shadowOpacity
      animation.toValue = 1
      animation.duration = animationsDuration
      sender.layer.add(animation, forKey: animation.keyPath)
      sender.shadowOpacity = 1
    }
  }

  func baseSwitchTouchUpInside(_ sender: PWSwitch) {
    if sender.on {
      sender.shadowOpacity = 1
    } else {
      sender.shadowOpacity = 0
      sender.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
    }
  }

  func baseSwitchTouchUpOutside(_ sender: PWSwitch) {
    if sender.on {
      let animation = CABasicAnimation(keyPath: "shadowOpacity")
      animation.fromValue = sender.shadowOpacity
      sender.layer.borderColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37).cgColor
      animation.toValue = 1
      animation.duration = animationsDuration
      sender.layer.add(animation, forKey: animation.keyPath)
      sender.shadowOpacity = 1
    } else {
      if sender.layer.borderColor == UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37).cgColor {
        sender.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
      }
      let animation = CABasicAnimation(keyPath: "shadowOpacity")
      animation.fromValue = sender.shadowOpacity
      animation.toValue = 0
      animation.duration = animationsDuration
      sender.layer.add(animation, forKey: animation.keyPath)
      sender.shadowOpacity = 0
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
    diarySelectButtonTappedAction(from: diaryFillingTimeSelectedBackgroundViewPosition, to: 0)
    notificationsProcesses.scheduleNotification(notificationType: "DiaryFillingNotificationID", hour: 22, minute: 30, frequency: nil)
  }

  @IBAction func secondTimeFillingDiaryButton(_ sender: UIButton) {
    diarySelectButtonTappedAction(from: diaryFillingTimeSelectedBackgroundViewPosition, to: 1)
    notificationsProcesses.scheduleNotification(notificationType: "DiaryFillingNotificationID", hour: 23, minute: 00, frequency: nil)
  }

  @IBAction func thirdTimeFillingDiaryButton(_ sender: UIButton) {
    diarySelectButtonTappedAction(from: diaryFillingTimeSelectedBackgroundViewPosition, to: 2)
    notificationsProcesses.scheduleNotification(notificationType: "DiaryFillingNotificationID", hour: 23, minute: 30, frequency: nil)
  }

  @IBAction func fourthTimeFillingDiaryButton(_ sender: UIButton) {
    diarySelectButtonTappedAction(from: diaryFillingTimeSelectedBackgroundViewPosition, to: 3)
    notificationsProcesses.scheduleNotification(notificationType: "DiaryFillingNotificationID", hour: 0, minute: 0, frequency: nil)
  }


  @IBAction func dailyFrequencyTaskButton(_ sender: UIButton) {
    tasksSelectButtonTappedAction(from: tasksFillingTimeSelectedBackgroundViewPosition, to: 0)
    notificationsProcesses.tasksNotificationsStatus = "daily"
  }

  @IBAction func weeklyFrequencyTaskButton(_ sender: UIButton) {
    tasksSelectButtonTappedAction(from: tasksFillingTimeSelectedBackgroundViewPosition, to: 1)
    notificationsProcesses.tasksNotificationsStatus = "weekly"
  }

  @IBAction func monthlyFrequencyTaskButton(_ sender: UIButton) {
    tasksSelectButtonTappedAction(from: tasksFillingTimeSelectedBackgroundViewPosition, to: 2)
    notificationsProcesses.tasksNotificationsStatus = "monthly"
  }



  // MARK: - Diary Select Button Tapped Action
  func diarySelectButtonTappedAction(from position: Int, to destination: Int) {
    var buttonFrom: UIButton
    var buttonTo: UIButton
    var xPosition = 0
    let yPosition = Int(62 + 7.5)

    switch position {
    case 0:
      buttonFrom = self.firstTimeFillingDiaryButton
    case 1:
      buttonFrom = self.secondTimeFillingDiaryButton
    case 2:
      buttonFrom = self.thirdTimeFillingDiaryButton
    default:
      buttonFrom = self.fourthTimeFillingDiaryButton
    }

    switch destination {
    case 0:
      buttonTo = self.firstTimeFillingDiaryButton
      xPosition = 20
    case 1:
      buttonTo = self.secondTimeFillingDiaryButton
      switch UIScreen.main.bounds.height {
      case 568: // iPhone SE
        xPosition = 90
      case 667: // iPhone 6/6s/7/8
        xPosition = 108
      case 736: // iPhone 6 Plus/6s Plus/7 Plus/8 Plus
        xPosition = 121
      case 812: // iPhone X/Xs
        xPosition = 108
      default:  // iPhone Xs Max/Xr
        xPosition = 121
      }
    case 2:
      buttonTo = self.thirdTimeFillingDiaryButton
      switch UIScreen.main.bounds.height {
      case 568: // iPhone SE
        xPosition = 160
      case 667: // iPhone 6/6s/7/8
        xPosition = 197
      case 736: // iPhone 6 Plus/6s Plus/7 Plus/8 Plus
        xPosition = 223
      case 812: // iPhone X/Xs
        xPosition = 197
      default:  // iPhone Xs Max/Xr
        xPosition = 223
      }
    default:
      buttonTo = self.fourthTimeFillingDiaryButton
      switch UIScreen.main.bounds.height {
      case 568: // iPhone SE
        xPosition = 230
      case 667: // iPhone 6/6s/7/8
        xPosition = 286
      case 736: // iPhone 6 Plus/6s Plus/7 Plus/8 Plus
        xPosition = 324
      case 812: // iPhone X/Xs
        xPosition = 286
      default:  // iPhone Xs Max/Xr
        xPosition = 324
      }
    }

    selectingAnimation(timeBackgroundView, position, destination, animationsDuration, animationsDuration / 3, xPosition, yPosition, buttonFrom, buttonTo)

    self.diaryFillingTimeSelectedBackgroundViewPosition = destination
  }

  // MARK: - Tasks Select Button Tapped Action
  func tasksSelectButtonTappedAction(from position: Int, to destination: Int) {
    var buttonFrom: UIButton
    var buttonTo: UIButton
    var xPosition = 0
    let yPosition = Int(62 + 7.5)

    switch position {
    case 0:
      buttonFrom = self.dailyFrequencyTaskButton
    case 1:
      buttonFrom = self.weeklyFrequencyTaskButton
    default:
      buttonFrom = self.monthlyFrequencyTaskButton
    }

    switch destination {
    case 0:
      buttonTo = self.dailyFrequencyTaskButton
      xPosition = 20
    case 1:
      buttonTo = self.weeklyFrequencyTaskButton
      switch UIScreen.main.bounds.height {
      case 568: // iPhone SE
        xPosition = 118
      case 667: // iPhone 6/6s/7/8
        xPosition = 145
      case 736: // iPhone 6 Plus/6s Plus/7 Plus/8 Plus
        xPosition = 164
      case 812: // iPhone X/Xs
        xPosition = 145
      default:  // iPhone Xs Max/Xr
        xPosition = 164
      }
    default:
      buttonTo = self.monthlyFrequencyTaskButton
      switch UIScreen.main.bounds.height {
      case 568: // iPhone SE
        xPosition = 226
      case 667: // iPhone 6/6s/7/8
        xPosition = 280
      case 736: // iPhone 6 Plus/6s Plus/7 Plus/8 Plus
        xPosition = 320
      case 812: // iPhone X/Xs
        xPosition = 280
      default:  // iPhone Xs Max/Xr
        xPosition = 320
      }
    }

    selectingAnimation(frequencyBackgroundView, position, destination, animationsDuration, animationsDuration / 3, xPosition, yPosition, buttonFrom, buttonTo)

    self.tasksFillingTimeSelectedBackgroundViewPosition = destination
  }

  // MARK: - Selecting Animation
  func selectingAnimation(_ view: UIView,
                          _ position: Int,
                          _ destination: Int,
                          _ duration: TimeInterval,
                          _ delay: TimeInterval,
                          _ xPosition: Int,
                          _ yPosition: Int,
                          _ buttonFrom: UIButton,
                          _ buttonTo: UIButton) {
    if position != destination {
      UIView.animate(withDuration: duration, animations: {
        view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5) // Уменьшаем форму

        UIView.transition(with: buttonFrom, duration: duration / 2, options: .transitionCrossDissolve, animations: {
          buttonFrom.setTitleColor(UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 0.9), for: .normal) // Меняем цвет шрифта текста той кнопки от которой вышли
        })
      })


      UIView.animate(withDuration: duration, delay: delay, animations: {
        view.frame = CGRect(x: xPosition, y: yPosition, width: 30, height: 15) // Передвигаем куда нужно
      })

      UIView.animate(withDuration: duration, delay: duration, animations: {
        view.transform = CGAffineTransform(scaleX: 1, y: 1) // Увеличиваем форму

        UIView.transition(with: buttonTo, duration: duration / 2, options: .transitionCrossDissolve, animations: {
          buttonTo.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal) // Меняем цвет шрифта текста той кнопки в которую пришли
        })
      })
    }
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

      switchElement.layer.borderWidth = 1.5
      switchElement.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor

      switchElement.layer.cornerRadius = 15.5
      switchElement.thumbCornerRadius = 5
      switchElement.thumbDiameter = 20

      switchElement.trackOffFillColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1)
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

  // MARK: - Select Button Backgroung View
  func selectButtonsBackgroundViewing(for view: UIView) {
    var view = view
    var buttonsList = [UIButton]()
    var firstButton = firstTimeFillingDiaryButton!

    switch view {
    case timeBackgroundView:
      buttonsList = [secondTimeFillingDiaryButton!, thirdTimeFillingDiaryButton!, fourthTimeFillingDiaryButton!]
      view.frame = CGRect(x: 4, y: 62, width: 60, height: 30)
      diaryFillingTimeSelectedBackgroundViewPosition = 0
    default:
      view = frequencyBackgroundView
      firstButton = dailyFrequencyTaskButton
      buttonsList = [weeklyFrequencyTaskButton!, monthlyFrequencyTaskButton!]
      view.frame = CGRect(x: 4, y: 62, width: 60, height: 30)
      tasksFillingTimeSelectedBackgroundViewPosition = 0
    }


    firstButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)

    buttonsList.forEach { (button) in
      button.setTitleColor(UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 0.9), for: .normal)
    }

    view.cornerRadius = 5
    view.backgroundColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 1)
    view.shadowColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37).cgColor
    view.shadowOpacity = 1
    view.shadowRadius = 5
    view.shadowOffset = CGSize(width: 0, height: 5)
  }
}
