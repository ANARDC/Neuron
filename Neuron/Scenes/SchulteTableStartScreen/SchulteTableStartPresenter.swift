//
//  SchulteTableStartPresenter.swift
//  Neuron
//
//  Created by Anar on 03.11.2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit
import PWSwitch

protocol SchulteTableStartPresenterProtocol {
  func viewDidLoad()
  func viewDidAppear()
  
  func oneColorSelected()
  func twoColorsSelected()
  func threeColorsSelected()
  
  func startGame(data: SchulteTableGameSettings)
  func prepare(for segue: UIStoryboardSegue, sender: Any?)
  
  func mixingShadesSwitchValueChanged(_: PWSwitch)
  func mixingShadesSwitchTouchDown(_: PWSwitch)
  func mixingShadesSwitchTouchUpInside(_: PWSwitch)
  func mixingShadesSwitchTouchUpOutside(_: PWSwitch)
  func mixingShadesSwitchTouchDragExit(_: PWSwitch)
}

final class SchulteTableStartPresenter: SchulteTableStartPresenterProtocol {
  var view: SchulteTableStartViewControllerProtocol?
  
  init(view: SchulteTableStartViewControllerProtocol) {
    self.view = view
  }
  
  func viewDidLoad() {
    self.view?.getColorsCountChoose()
    
    self.view?.makeView()
    self.view?.navBarSetting()
    self.view?.makeNavBarTitle()
    self.view?.makeRulesTitleLabel()
    self.view?.makeRulesTextLabel()
    self.view?.makeSettingBackgroundView()
    self.view?.makeMixingShadesOptionTitle()
    self.view?.makeMixingShadesSwitch()
    self.view?.makeColorsCountSelectingButtons()
    self.view?.setColorsButtonsBackgroundViewFrame()
    self.view?.makeColorsButtonsBackgroundView()
    self.view?.makeSettingsCollectionView()
    self.view?.collectionViewSetting()
    self.view?.makeRecordTitleLabel()
    self.view?.makeRecordTimeLabel()
    self.view?.makeChooseBackgroundView()
    self.view?.makeChooseViewLabel()
  }
  
  func viewDidAppear() {
    self.view?.saveColorsCountChooseButtonsFrames()
  }
}

// MARK: - Start Game

extension SchulteTableStartPresenter {
  
  // MARK: - startGame
  func startGame(data: SchulteTableGameSettings) {
    guard self.view!.settingsIsReady else { return }
    self.view?.goToGameScreen(data: data)
  }
  
  func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "startGameSchulteTableSegue" else { return }
    
    if let settingsData = sender as? SchulteTableGameSettings {
      let destination = segue.destination as! SchulteTableGameViewController
      destination.settingsData = settingsData
    }
  }
}

// MARK: - Colors Count Selecting Buttons

extension SchulteTableStartPresenter {
  
  // MARK: - oneColorSelected
  func oneColorSelected() {
    self.view?.selectingAnimation(self.view!.colorsCountChoose,
                                  1)
    self.view?.setColorsCountChoose(1)
    self.view?.saveColorsButtonsBackgroundViewFrame()
  }
  
  // MARK: - twoColorsSelected
  func twoColorsSelected() {
    self.view?.selectingAnimation(self.view!.colorsCountChoose,
                                  2)
    self.view?.setColorsCountChoose(2)
    self.view?.saveColorsButtonsBackgroundViewFrame()
  }
  
  // MARK: - threeColorsSelected
  func threeColorsSelected() {
    self.view?.selectingAnimation(self.view!.colorsCountChoose,
                                  3)
    self.view?.setColorsCountChoose(3)
    self.view?.saveColorsButtonsBackgroundViewFrame()
  }
}

// MARK: - Switch Functions

extension SchulteTableStartPresenter {
  
  // MARK: - mixingShadesSwitchValueChanged
  func mixingShadesSwitchValueChanged(_ sender: PWSwitch) {
    switch sender.on {
    case true:
      sender.layer.borderColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37).cgColor
      sender.shadowOpacity = 1
    case false:
      sender.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
      sender.shadowOpacity = 0
    }
    
    self.view!.mixingShades = sender.on
  }
  
  // MARK: - mixingShadesSwitchTouchDown
  func mixingShadesSwitchTouchDown(_ sender: PWSwitch) {
    if sender.on {
      let animation            = CABasicAnimation(keyPath: "shadowOpacity")
      animation.fromValue      = sender.shadowOpacity
      animation.toValue        = 0
      animation.duration       = 0.4
      sender.shadowOpacity     = 0
      sender.layer.add(animation, forKey: animation.keyPath)
    } else {
      sender.layer.borderColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37).cgColor
      let animation            = CABasicAnimation(keyPath : "shadowOpacity")
      animation.fromValue      = sender.shadowOpacity
      animation.toValue        = 1
      animation.duration       = 0.4
      sender.shadowOpacity     = 1
      sender.layer.add(animation, forKey: animation.keyPath)
    }
  }
  
  // MARK: - mixingShadesSwitchTouchUpInside
  func mixingShadesSwitchTouchUpInside(_ sender: PWSwitch) {
    if sender.on {
      sender.shadowOpacity = 1
    } else {
      sender.shadowOpacity = 0
      sender.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
    }
  }
  
  // MARK: - mixingShadesSwitchTouchUpOutside
  func mixingShadesSwitchTouchUpOutside(_ sender: PWSwitch) {
    if sender.on {
      let animation            = CABasicAnimation(keyPath: "shadowOpacity")
      animation.fromValue      = sender.shadowOpacity
      sender.layer.borderColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37).cgColor
      animation.toValue        = 1
      animation.duration       = 0.4
      sender.shadowOpacity     = 1
      sender.layer.add(animation, forKey: animation.keyPath)
    } else {
      if sender.layer.borderColor == UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37).cgColor {
        sender.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
      }
      let animation        = CABasicAnimation(keyPath: "shadowOpacity")
      animation.fromValue  = sender.shadowOpacity
      animation.toValue    = 0
      animation.duration   = 0.4
      sender.shadowOpacity = 0
      sender.layer.add(animation, forKey: animation.keyPath)
    }
  }
  
  // MARK: - mixingShadesSwitchTouchDragExit
  func mixingShadesSwitchTouchDragExit(_ sender: PWSwitch) {
    if sender.on {
      sender.layer.borderColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37).cgColor
    }
  }
}
