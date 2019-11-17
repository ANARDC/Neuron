//
//  SchulteTableStartPresenter.swift
//  Neuron
//
//  Created by Anar on 03.11.2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit
import PWSwitch

protocol SchulteTableStartPresenterDelegate {
  func viewDidLoad()
  
  func oneOrderSelected()
  func twoOrdersSelected()
  func threeOrdersSelected()
  
  func mixingShadesSwitchValueChanged(_: PWSwitch)
  func mixingShadesSwitchTouchDown(_: PWSwitch)
  func mixingShadesSwitchTouchUpInside(_: PWSwitch)
  func mixingShadesSwitchTouchUpOutside(_: PWSwitch)
  func mixingShadesSwitchTouchDragExit(_: PWSwitch)
}

final class SchulteTableStartPresenter: SchulteTableStartPresenterDelegate {
  var view: SchulteTableStartViewControllerDelegate?
  
  init(view: SchulteTableStartViewControllerDelegate) {
    self.view = view
  }
  
  func viewDidLoad() {
    self.view?.getOrdersCountChoose()
    
    self.view?.makeNavBarTitle()
    self.view?.navBarSetting()
    self.view?.makeRulesTitleLabel()
    self.view?.makeRulesTextLabel()
    self.view?.makeSettingBackgroundView()
    self.view?.makeMixingShadesOptionTitle()
    self.view?.makeMixingShadesSwitch()
    self.view?.makeOrdersCountSelectingButtons()
    self.view?.setOrdersButtonsBackgroundViewFrame()
    self.view?.makeOrdersButtonsBackgroundView()
    self.view?.collectionViewSetting()
    self.view?.makeRecordTitleLabel()
    self.view?.makeRecordTimeLabel()
    self.view?.makeChooseBackgroundView()
    self.view?.makeChooseViewLabel()
  }
}

// MARK: - Orders Count Selecting Buttons

extension SchulteTableStartPresenter {
  
  // MARK: - oneOrderSelected
  func oneOrderSelected() {
    self.view?.selectingAnimation(self.view!.ordersCountChoose,
                                  1)
    self.view?.setOrdersCountChoose(1)
    self.view?.saveOrdersButtonsBackgroundViewFrame()
  }
  
  // MARK: - twoOrdersSelected
  func twoOrdersSelected() {
    self.view?.selectingAnimation(self.view!.ordersCountChoose,
                                  2)
    self.view?.setOrdersCountChoose(2)
    self.view?.saveOrdersButtonsBackgroundViewFrame()
  }
  
  // MARK: - threeOrdersSelected
  func threeOrdersSelected() {
    self.view?.selectingAnimation(self.view!.ordersCountChoose,
                                  3)
    self.view?.setOrdersCountChoose(3)
    self.view?.saveOrdersButtonsBackgroundViewFrame()
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
    default:
      sender.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
      sender.shadowOpacity = 0
    }
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
