//
//  SchulteTableStartViewController.swift
//  Neuron
//
//  Created by Anar on 02.11.2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit
import PWSwitch

protocol SchulteTableStartViewControllerDelegate {
  var configurator : SchulteTableStartConfigurator!      { get set }
  var presenter    : SchulteTableStartPresenterDelegate! { get set }
  
  func makeNavBarTitle()
  func navBarSetting()
  func makeRulesTitleLabel()
  func makeRulesTextLabel()
  func makeSettingBackgroundView()
  func makeMixingShadesOptionTitle()
  func makeMixingShadesSwitch()
  func makeOrderCountSelectingButtons()
}

final class SchulteTableStartViewController: UIViewController, SchulteTableStartViewControllerDelegate {
  var configurator : SchulteTableStartConfigurator!
  var presenter    : SchulteTableStartPresenterDelegate!
  
  @IBOutlet weak var statsButton : UIBarButtonItem!
  
  @IBOutlet weak var rulesTitleLabel : UILabel!
  @IBOutlet weak var rulesTextLabel  : UILabel!
  
  @IBOutlet weak var settingBackgroundView   : UIView!
  @IBOutlet weak var mixingShadesOptionTitle : UILabel!
  @IBOutlet weak var mixingShadesSwitch      : PWSwitch!
  @IBOutlet weak var oneOrderButton          : UIButton!
  @IBOutlet weak var twoOrdersButton         : UIButton!
  @IBOutlet weak var threeOrdersButton       : UIButton!
  
  @IBOutlet weak var settingsCollectionView : UICollectionView!
  @IBOutlet weak var recordTitleLabel       : UILabel!
  @IBOutlet weak var recordTimeLabel        : UILabel!
  @IBOutlet var recordStars                 : [UIImageView]!
  
  @IBOutlet weak var chooseBackgroundView : UIView!
  @IBOutlet weak var leftArrow            : UIImageView!
  @IBOutlet weak var rightArrow           : UIImageView!
  @IBOutlet weak var chooseViewLabel      : UILabel!
  
  
  @IBAction func mixingShadesSwitchValueChanged(_ sender: PWSwitch) {
    self.presenter.mixingShadesSwitchValueChanged(sender)
  }
  
  @IBAction func mixingShadesSwitchTouchDown(_ sender: PWSwitch) {
    self.presenter.mixingShadesSwitchTouchDown(sender)
  }
  
  @IBAction func mixingShadesSwitchTouchUpInside(_ sender: PWSwitch) {
    self.presenter.mixingShadesSwitchTouchUpInside(sender)
  }
  
  @IBAction func mixingShadesSwitchTouchUpOutside(_ sender: PWSwitch) {
    self.presenter.mixingShadesSwitchTouchUpOutside(sender)
  }
  
  @IBAction func mixingShadesSwitchTouchDragExit(_ sender: PWSwitch) {
    self.presenter.mixingShadesSwitchTouchDragExit(sender)
  }
}

extension SchulteTableStartViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configurator = SchulteTableStartConfiguratorImplementation(self)
    self.configurator.configure(self)
    self.presenter.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    self.tabBarController?.tabBar.isHidden = true
  }
}

extension SchulteTableStartViewController {
  
  // MARK: - makeNavBarTitle
  func makeNavBarTitle() {
    let navBarTitleFont      = UIFont(name: "NotoSans-Bold", size: 23)!
    let navBarTitleFontColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 0.9)

    self.navigationItem.title = "Schulte Table"
    
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navBarTitleFont,
                                                                    NSAttributedString.Key.foregroundColor: navBarTitleFontColor]
  }
  
  // MARK: - navBarSetting
  func navBarSetting() {
    BarDesign().customizeNavBar(navigationController: self.navigationController, navigationItem: self.navigationItem)
    statsButton.image = UIImage(named: "Статистика")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
  }
  
  // MARK: - makeRulesTitleLabel
  func makeRulesTitleLabel() {
    self.rulesTitleLabel.font      = UIFont(name: "NotoSans-Bold", size: 17)
    self.rulesTitleLabel.textColor = UIColor(red: 0.152, green: 0.239, blue: 0.323, alpha: 0.9)
    self.rulesTitleLabel.text      = "Rules"
  }
  
  // MARK: - makeRulesTextLabel
  func makeRulesTextLabel() {
    self.rulesTextLabel.font          = UIFont(name: "NotoSans-Regular", size: 14)
    self.rulesTextLabel.textColor     = UIColor(red: 0.153, green: 0.239, blue: 0.322, alpha: 0.8)
    self.rulesTextLabel.numberOfLines = 0
    self.rulesTextLabel.text          = "Line 1\nLine 2\nLine 3\nLine 4\nLine 5\nLine 6"
  }
  
  // MARK: - makeSettingBackgroundView
  func makeSettingBackgroundView() {
    self.settingBackgroundView.backgroundColor = .white
    self.settingBackgroundView.shadowColor     = UIColor(red: 0.898, green: 0.925, blue: 0.929, alpha: 1).cgColor
    self.settingBackgroundView.shadowOpacity   = 1
    self.settingBackgroundView.shadowRadius    = 14
    self.settingBackgroundView.shadowOffset    = CGSize(width: 0, height: 11)
    self.settingBackgroundView.borderWidth     = 1
    self.settingBackgroundView.borderColor     = UIColor(red: 0.896, green: 0.926, blue: 0.931, alpha: 1).cgColor
    self.settingBackgroundView.cornerRadius    = 20
  }
  
  // MARK: - makeMixingShadesOptionTitle
  func makeMixingShadesOptionTitle() {
    self.mixingShadesOptionTitle.font      = UIFont(name: "NotoSans-Regular", size: 15)
    self.mixingShadesOptionTitle.textColor = UIColor(red: 0.153, green: 0.239, blue: 0.322, alpha: 0.9)
    self.mixingShadesOptionTitle.text      = "Mixing shades"
  }
  
  // MARK: - makeMixingShadesSwitch
  func makeMixingShadesSwitch() {
    self.mixingShadesSwitch.shadowColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37).cgColor
    self.mixingShadesSwitch.shadowOpacity = 0
    self.mixingShadesSwitch.shadowRadius = 5
    self.mixingShadesSwitch.shadowOffset = CGSize(width: 0, height: 5)

    self.mixingShadesSwitch.layer.borderWidth = 1.5
    self.mixingShadesSwitch.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor

    self.mixingShadesSwitch.layer.cornerRadius = 15.5
    self.mixingShadesSwitch.thumbCornerRadius = 5
    self.mixingShadesSwitch.thumbDiameter = 20

    self.mixingShadesSwitch.trackOffFillColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1)
    self.mixingShadesSwitch.trackOnFillColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37)
    self.mixingShadesSwitch.trackOnBorderColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 1)
    self.mixingShadesSwitch.trackOffPushBorderColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37)

    self.mixingShadesSwitch.thumbOnBorderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    self.mixingShadesSwitch.thumbOffBorderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    self.mixingShadesSwitch.thumbOnFillColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
  }
  
  // MARK: - makeOrderCountSelectingButtons
  func makeOrderCountSelectingButtons() {
    [self.oneOrderButton,
     self.twoOrdersButton,
     self.threeOrdersButton].forEach { (button) in
      button!.titleLabel?.minimumScaleFactor = 0.1
      button!.titleLabel?.numberOfLines = 1
      button!.titleLabel?.adjustsFontSizeToFitWidth = true
      button!.setTitleColor(UIColor(red: 0.153, green: 0.239, blue: 0.322, alpha: 0.9), for: .normal)
    }
  }
}
