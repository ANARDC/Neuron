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
  func makeOrdersButtonsBackgroundView()
  func collectionViewSetting()
  func makeRecordTitleLabel()
  func makeRecordTimeLabel()
  func makeChooseBackgroundView()
  func makeChooseViewLabel()
}

final class SchulteTableStartViewController: UIViewController, SchulteTableStartViewControllerDelegate {
  var configurator : SchulteTableStartConfigurator!
  var presenter    : SchulteTableStartPresenterDelegate!
  
  @IBOutlet weak var statsButton : UIBarButtonItem!
  
  @IBOutlet weak var rulesTitleLabel : UILabel!
  @IBOutlet weak var rulesTextLabel  : UILabel!
  
  @IBOutlet weak var settingBackgroundView       : UIView!
  @IBOutlet weak var mixingShadesOptionTitle     : UILabel!
  @IBOutlet weak var mixingShadesSwitch          : PWSwitch!
  @IBOutlet weak var oneOrderButton              : UIButton!
  @IBOutlet weak var twoOrdersButton             : UIButton!
  @IBOutlet weak var threeOrdersButton           : UIButton!
  @IBOutlet weak var ordersButtonsBackgroundView : UIView!
  @IBOutlet weak var settingsCollectionView      : UICollectionView!
  @IBOutlet weak var recordTitleLabel            : UILabel!
  @IBOutlet weak var recordTimeLabel             : UILabel!
  @IBOutlet var recordStars                      : [UIImageView]!
  
  @IBOutlet weak var chooseBackgroundView : UIView!
  @IBOutlet weak var leftArrow            : UIImageView!
  @IBOutlet weak var rightArrow           : UIImageView!
  @IBOutlet weak var chooseViewLabel      : UILabel!
  
  static var levelNumber = 1
  var choosenLevelNumber = 1
  
  var selectedCell: UICollectionViewCell? = nil
  
  let animationsDuration = 0.4
  
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
    self.mixingShadesSwitch.shadowColor   = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37).cgColor
    self.mixingShadesSwitch.shadowOpacity = 0
    self.mixingShadesSwitch.shadowRadius  = 5
    self.mixingShadesSwitch.shadowOffset  = CGSize(width: 0, height: 5)

    self.mixingShadesSwitch.layer.borderWidth = 1.5
    self.mixingShadesSwitch.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor

    self.mixingShadesSwitch.layer.cornerRadius = 15.5
    self.mixingShadesSwitch.thumbCornerRadius  = 5
    self.mixingShadesSwitch.thumbDiameter      = 20

    self.mixingShadesSwitch.trackOffFillColor       = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1)
    self.mixingShadesSwitch.trackOnFillColor        = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37)
    self.mixingShadesSwitch.trackOnBorderColor      = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 1)
    self.mixingShadesSwitch.trackOffPushBorderColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37)

    self.mixingShadesSwitch.thumbOnBorderColor  = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    self.mixingShadesSwitch.thumbOffBorderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    self.mixingShadesSwitch.thumbOnFillColor    = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
  }
  
  // MARK: - makeOrderCountSelectingButtons
  func makeOrderCountSelectingButtons() {
    [self.oneOrderButton,
     self.twoOrdersButton,
     self.threeOrdersButton].forEach { (button) in
      button!.titleLabel?.minimumScaleFactor        = 0.1
      button!.titleLabel?.numberOfLines             = 1
      button!.titleLabel?.adjustsFontSizeToFitWidth = true
      button!.setTitleColor(UIColor(red: 0.153, green: 0.239, blue: 0.322, alpha: 0.9), for: .normal)
    }
  }
  
  // MARK: - makeOrdersButtonsBackgroundView
  func makeOrdersButtonsBackgroundView() {
    self.ordersButtonsBackgroundView.shadowColor   = UIColor(red: 0.459, green: 0.608, blue: 0.98, alpha: 0.37).cgColor
    self.ordersButtonsBackgroundView.shadowOpacity = 1
    self.ordersButtonsBackgroundView.shadowRadius  = 5
    self.ordersButtonsBackgroundView.shadowOffset  = CGSize(width: 0, height: 5)
    
    self.ordersButtonsBackgroundView.backgroundColor = UIColor(red: 0.459, green: 0.608, blue: 0.98, alpha: 1)
    
    self.ordersButtonsBackgroundView.cornerRadius = 5
  }
  
  // MARK: - makeRecordTitleLabel
  func makeRecordTitleLabel() {
    self.recordTitleLabel.font                      = UIFont(name: "NotoSans", size: 16)
    self.recordTitleLabel.textColor                 = UIColor(red: 0.153, green: 0.239, blue: 0.322, alpha: 0.6)
    self.recordTitleLabel.adjustsFontSizeToFitWidth = true
    self.recordTitleLabel.numberOfLines             = 1
    self.recordTitleLabel.minimumScaleFactor        = 0.1
  }
  
  // MARK: - makeRecordTimeLabel
  func makeRecordTimeLabel() {
    self.recordTimeLabel.font                      = UIFont(name: "NotoSans", size: 26)
    self.recordTimeLabel.textColor                 = UIColor(red: 0.153, green: 0.239, blue: 0.322, alpha: 0.9)
    self.recordTimeLabel.adjustsFontSizeToFitWidth = true
    self.recordTimeLabel.numberOfLines             = 1
    self.recordTimeLabel.minimumScaleFactor        = 0.5
  }
  
  // MARK: - makeChooseBackgroundView
  func makeChooseBackgroundView() {
    self.chooseBackgroundView.shadowColor   = UIColor(red: 0.898, green: 0.925, blue: 0.929, alpha: 1).cgColor
    self.chooseBackgroundView.shadowOpacity = 1
    self.chooseBackgroundView.shadowRadius  = 14
    self.chooseBackgroundView.shadowOffset  = CGSize(width: 0, height: 11)
    
    self.chooseBackgroundView.backgroundColor = UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 1)
    
    self.chooseBackgroundView.cornerRadius = 24
    
    self.chooseBackgroundView.borderWidth = 2
    self.chooseBackgroundView.borderColor = UIColor(red: 0.153, green: 0.239, blue: 0.322, alpha: 1).cgColor
  }
  
  // MARK: - makeChooseViewLabel
  func makeChooseViewLabel() {
    self.chooseViewLabel.textColor = UIColor(red: 0.153, green: 0.239, blue: 0.322, alpha: 1)
    self.chooseViewLabel.font      = UIFont(name: "NotoSans-Bold", size: 20)
  }
}

// MARK: - UICollectionView functions

extension SchulteTableStartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 7
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    SchulteTableStartViewController.levelNumber = indexPath.row + 3
    self.settingsCollectionView.register(SchulteTableStartLevelsCollectionViewCell.self, forCellWithReuseIdentifier: "level\(indexPath.row)")
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "level\(indexPath.row)", for: indexPath)
    return cell
  }
  
  // MARK: - levelsCollectionView Delegate And DataSource
  func collectionViewSetting() {
    self.settingsCollectionView.delegate   = self
    self.settingsCollectionView.dataSource = self
  }
  
  // MARK: - Levels Collection Viewing
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 50, height: 28)
  }
  
  // MARK: - Did Select Item At
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath) else { return }

    let animation0       = CABasicAnimation(keyPath: "borderColor")
    animation0.fromValue = cell.borderColor
    animation0.toValue   = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 1).cgColor
    animation0.duration  = self.animationsDuration
    cell.layer.add(animation0, forKey: animation0.keyPath)

    let animation1       = CABasicAnimation(keyPath: "borderWidth")
    animation1.fromValue = cell.borderWidth
    animation1.toValue   = 2
    animation1.duration  = self.animationsDuration
    cell.layer.add(animation1, forKey: animation1.keyPath)

    let animation2       = CABasicAnimation(keyPath: "shadowOpacity")
    animation2.fromValue = cell.shadowOpacity
    animation2.toValue   = 0
    animation2.duration  = self.animationsDuration
    cell.layer.add(animation2, forKey: animation2.keyPath)

    cell.borderColor   = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 1).cgColor
    cell.borderWidth   = 2
    cell.shadowOpacity = 0

    self.chooseBackgroundView.backgroundColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 1)
    self.chooseBackgroundView.borderWidth     = 0

    self.chooseViewLabel.text      = "Start"
    self.chooseViewLabel.textColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1)

    self.leftArrow.isHidden  = true
    self.rightArrow.isHidden = true

    let nextArrow   = UIImageView()
    nextArrow.image = UIImage(named: "БелаяСтрелка")
    nextArrow.frame = CGRect(x: 283, y: 18, width: 7, height: 12)

    self.chooseBackgroundView.addSubview(nextArrow)

    self.choosenLevelNumber = indexPath.row + 1

    self.cellDidDeselect(for: collectionView, selectedCellIndexPath: indexPath)
  }
  
  // MARK: - cellDidDeselect
  func cellDidDeselect(for collectionView: UICollectionView, selectedCellIndexPath indexPath: IndexPath) {
    if let selectedCell = self.selectedCell {
      guard collectionView.indexPath(for: selectedCell) != indexPath else { return }

      let SCAnimation0       = CABasicAnimation(keyPath: "borderColor")
      SCAnimation0.fromValue = selectedCell.borderColor
      SCAnimation0.toValue   = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
      SCAnimation0.duration  = self.animationsDuration
      selectedCell.layer.add(SCAnimation0, forKey: SCAnimation0.keyPath)

      let SCAnimation1       = CABasicAnimation(keyPath: "borderWidth")
      SCAnimation1.fromValue = selectedCell.borderWidth
      SCAnimation1.toValue   = 1
      SCAnimation1.duration  = self.animationsDuration
      selectedCell.layer.add(SCAnimation1, forKey: SCAnimation1.keyPath)

      let SCAnimation2       = CABasicAnimation(keyPath: "shadowOpacity")
      SCAnimation2.fromValue = selectedCell.shadowOpacity
      SCAnimation2.toValue   = 1
      SCAnimation2.duration  = self.animationsDuration
      selectedCell.layer.add(SCAnimation2, forKey: SCAnimation2.keyPath)

      selectedCell.borderColor   = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
      selectedCell.borderWidth   = 1
      selectedCell.shadowOpacity = 1
    }

    self.selectedCell = collectionView.cellForItem(at: indexPath)
  }
}
