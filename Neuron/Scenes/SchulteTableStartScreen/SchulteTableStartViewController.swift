//
//  SchulteTableStartViewController.swift
//  Neuron
//
//  Created by Anar on 02.11.2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit
import PWSwitch

protocol SchulteTableStartViewControllerProtocol {
  var configurator : SchulteTableStartConfigurator!      { get set }
  var presenter    : SchulteTableStartPresenterProtocol! { get set }
  
  var mixingShades      : Bool! { get set }
  var colorsCountChoose : Int!  { get }

  var settingsData : SchulteTableGameSettings! { get set }
  
  var settingsIsReady : Bool! { get }
  
  func selectingAnimation(_ position    : Int,
                          _ destination : Int)
  func setColorsCountChoose(_: Int)
  func getColorsCountChoose()
  func saveColorsButtonsBackgroundViewFrame()
  func setColorsButtonsBackgroundViewFrame()
  func saveColorsCountChooseButtonsFrames()
  
  func goToGameScreen(data: SchulteTableGameSettings)
  
  func makeView()
  func makeNavBarTitle()
  func navBarSetting()
  func makeRulesTitleLabel()
  func makeRulesTextLabel()
  func makeSettingBackgroundView()
  func makeMixingShadesOptionTitle()
  func makeMixingShadesSwitch()
  func makeColorsCountSelectingButtons()
  func makeColorsButtonsBackgroundView()
  func makeSettingsCollectionView()
  func collectionViewSetting()
  func makeRecordTitleLabel()
  func makeRecordTimeLabel()
  func makeChooseBackgroundView()
  func makeChooseViewLabel()
}

final class SchulteTableStartViewController: UIViewController, SchulteTableStartViewControllerProtocol {
  var configurator : SchulteTableStartConfigurator!
  var presenter    : SchulteTableStartPresenterProtocol!
  
  @IBOutlet weak var statsButton : UIBarButtonItem!
  
  @IBOutlet weak var rulesTitleLabel : UILabel!
  @IBOutlet weak var rulesTextLabel  : UILabel!
  
  @IBOutlet weak var settingBackgroundView       : UIView!
  @IBOutlet weak var mixingShadesOptionTitle     : UILabel!
  @IBOutlet weak var mixingShadesSwitch          : PWSwitch!
  @IBOutlet weak var oneColorButton              : UIButton!
  @IBOutlet weak var twoColorsButton             : UIButton!
  @IBOutlet weak var threeColorsButton           : UIButton!
  @IBOutlet weak var colorsButtonsBackgroundView : UIView!
  @IBOutlet weak var settingsCollectionView      : UICollectionView!
  @IBOutlet weak var recordTitleLabel            : UILabel!
  @IBOutlet weak var recordTimeLabel             : UILabel!
  @IBOutlet var recordStars                      : [UIImageView]!
  
  @IBOutlet weak var chooseBackgroundView : UIView!
  @IBOutlet weak var leftArrow            : UIImageView!
  @IBOutlet weak var rightArrow           : UIImageView!
  @IBOutlet weak var chooseViewLabel      : UILabel!
  
  var mixingShades      : Bool! = false
  var colorsCountChoose : Int!
  var levelNumber       : Int = 1

  var settingsData : SchulteTableGameSettings!
  
  var settingsIsReady : Bool! = false
  
  static var levelNumberForSettingsCollectionViewCellsAppear = 1
  
  var selectedCell: UICollectionViewCell? = nil
  
  let animationsDuration = 0.4
  
  // Это нужно для нижнего вью
  // у попапа, в котором лежит конфигуратор
  static var colorsCountChooseButtonsFrames = [Int: CGRect]()
}

// MARK: - Life Cycle

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
    self.getColorsCountChoose()
    self.makeColorsCountSelectingButtons()
    self.setColorsButtonsBackgroundViewFrame()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.presenter.viewDidAppear()
    self.setColorsButtonsBackgroundViewFrame()
  }
  
//  override func viewDidDisappear(_ animated: Bool) {
//    super.viewDidDisappear(animated)
//    self.saveColorsCountChooseButtonsFrames()
//  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.saveColorsCountChooseButtonsFrames()
  }
}

// MARK: - Colors Count Selecting

extension SchulteTableStartViewController {
  
  // MARK: - oneColorButton
  @IBAction func oneColorButton(_ sender: UIButton) {
    self.presenter.oneColorSelected()
  }
  
  // MARK: - twoColorsButton
  @IBAction func twoColorsButton(_ sender: UIButton) {
    self.presenter.twoColorsSelected()
  }
  
  // MARK: - threeColorsButton
  @IBAction func threeColorsButton(_ sender: UIButton) {
    self.presenter.threeColorsSelected()
  }
  
  // MARK: - selectingAnimation
  func selectingAnimation(_ position    : Int,
                          _ destination : Int) {
    if position != destination {
      let buttons    = [self.oneColorButton, self.twoColorsButton, self.threeColorsButton]
      let buttonFrom = buttons[position - 1]!
      let buttonTo   = buttons[destination - 1]!
      
      UIView.animate(withDuration: self.animationsDuration, animations: {
        self.colorsButtonsBackgroundView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5) // Уменьшаем форму

        UIView.transition(with: buttonFrom, duration: self.animationsDuration / 2, options: .transitionCrossDissolve, animations: {
          buttonFrom.setTitleColor(UIColor(red: 0.153, green: 0.239, blue: 0.322, alpha: 0.9), for: .normal) // Меняем цвет шрифта текста той кнопки от которой вышли
        })
      })

      UIView.animate(withDuration: self.animationsDuration, delay: self.animationsDuration / 3, animations: {
//        self.colorsButtonsBackgroundView.frame = CGRect(x: xPosition, y: yPosition, width: 30, height: 15) // Передвигаем куда нужно
        
        // Получаем координаты выбранной в прошлый раз кнопки относительно settingBackgroundView, а не своего UIStackView
        let settingBackgroundViewConvertedFrame = self.settingBackgroundView.convert(buttonTo.frame, from: buttonTo.superview)
        
//        // Сначала задаем размеры
//        self.colorsButtonsBackgroundView.frame.size.width  = 82
//        self.colorsButtonsBackgroundView.frame.size.height = 32
        
        // И только затем устанавливаем координаты центра
        self.colorsButtonsBackgroundView.center = CGPoint(x: settingBackgroundViewConvertedFrame.minX + buttonTo.frame.size.width / 2,
                                                          y: settingBackgroundViewConvertedFrame.minY + buttonTo.frame.size.height / 2)
      })

      UIView.animate(withDuration: self.animationsDuration, delay: self.animationsDuration, animations: {
        self.colorsButtonsBackgroundView.transform = CGAffineTransform(scaleX: 1, y: 1) // Увеличиваем форму

        UIView.transition(with: buttonTo, duration: self.animationsDuration / 2, options: .transitionCrossDissolve, animations: {
          buttonTo.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.9), for: .normal) // Меняем цвет шрифта текста той кнопки в которую пришли
        })
      })
    }
  }
  
  // MARK: - setColorsCountChoose
  func setColorsCountChoose(_ colorsCount: Int) {
    UserDefaults.standard.set(colorsCount, forKey: "schulteTableGameColorsCountChooseKey")
    self.colorsCountChoose = colorsCount
  }
  
  // MARK: - getColorsCountChoose
  func getColorsCountChoose() {
    guard UserDefaults.standard.integer(forKey: "schulteTableGameColorsCountChooseKey") != 0 else {
      UserDefaults.standard.set(1, forKey: "schulteTableGameColorsCountChooseKey")
      self.colorsCountChoose = 1
      return
    }
    self.colorsCountChoose = UserDefaults.standard.integer(forKey: "schulteTableGameColorsCountChooseKey")
  }
  
  // MARK: - saveColorsButtonsBackgroundViewFrame
  func saveColorsButtonsBackgroundViewFrame() {
//    let viewFrameX      = self.colorsButtonsBackgroundView.frame.minX
//    let viewFrameY      = self.colorsButtonsBackgroundView.frame.minY
//    let viewFrameWidth  = self.colorsButtonsBackgroundView.frame.size.width
//    let viewFrameHeight = self.colorsButtonsBackgroundView.frame.size.height
//
//    UserDefaults.standard.set(viewFrameX, forKey: "colorsButtonsBackgroundViewFrameX")
//    UserDefaults.standard.set(viewFrameY, forKey: "colorsButtonsBackgroundViewFrameY")
//    UserDefaults.standard.set(viewFrameWidth, forKey: "colorsButtonsBackgroundViewFrameWidth")
//    UserDefaults.standard.set(viewFrameHeight, forKey: "colorsButtonsBackgroundViewFrameHeight")
    
    let viewFrame = SchulteTableStartViewController.colorsCountChooseButtonsFrames[self.colorsCountChoose - 1]!
    
    let viewFrameX      = viewFrame.minX
    let viewFrameY      = viewFrame.minY
    let viewFrameWidth  = 82
    let viewFrameHeight = 32
    
    UserDefaults.standard.set(viewFrameX, forKey: "colorsButtonsBackgroundViewFrameX")
    UserDefaults.standard.set(viewFrameY, forKey: "colorsButtonsBackgroundViewFrameY")
    UserDefaults.standard.set(viewFrameWidth, forKey: "colorsButtonsBackgroundViewFrameWidth")
    UserDefaults.standard.set(viewFrameHeight, forKey: "colorsButtonsBackgroundViewFrameHeight")
  }
  
  // MARK: - setColorsButtonsBackgroundViewFrame
  func setColorsButtonsBackgroundViewFrame() {
    let buttons = [self.oneColorButton, self.twoColorsButton, self.threeColorsButton]
    
    let viewFrameX      = CGFloat(UserDefaults.standard.float(forKey: "colorsButtonsBackgroundViewFrameX"))
    let viewFrameY      = CGFloat(UserDefaults.standard.float(forKey: "colorsButtonsBackgroundViewFrameY"))
    let viewFrameWidth  = CGFloat(UserDefaults.standard.float(forKey: "colorsButtonsBackgroundViewFrameWidth"))
    let viewFrameHeight = CGFloat(UserDefaults.standard.float(forKey: "colorsButtonsBackgroundViewFrameHeight"))
    
    guard viewFrameX != 0 || viewFrameY != 0 || viewFrameWidth != 0 || viewFrameHeight != 0 else { return }
    
//    self.colorsButtonsBackgroundView.frame = CGRect(x: viewFrameX, y: viewFrameY, width: viewFrameWidth, height: viewFrameHeight)
    
    self.colorsButtonsBackgroundView.center = CGPoint(x: viewFrameX + buttons[self.colorsCountChoose - 1]!.frame.size.width / 2,
                                                      y: viewFrameY + buttons[self.colorsCountChoose - 1]!.frame.size.height / 2)
    self.colorsButtonsBackgroundView.frame.size = CGSize(width: viewFrameWidth, height: viewFrameHeight)
  }
  
  // MARK: - saveColorsCountChooseButtonsFrames
  func saveColorsCountChooseButtonsFrames() {
    [self.oneColorButton, self.twoColorsButton, self.threeColorsButton].enumerated().forEach { (index: Int, button: UIButton) in
      SchulteTableStartViewController.colorsCountChooseButtonsFrames[index] = self.settingBackgroundView.convert(button.frame, from: button.superview)
    }
  }
}

// MARK: - Start Game

extension SchulteTableStartViewController {
  
  // MARK: - startGame
  @IBAction func startGame(_ sender: UITapGestureRecognizer) {
    let settingsData = SchulteTableGameSettings(mixingShades: self.mixingShades,
                                                levelNumber: self.levelNumber,
                                                colorsCount: self.colorsCountChoose)
    self.presenter.startGame(data: settingsData)
  }
  
  // MARK: - goToGameScreen
  func goToGameScreen(data: SchulteTableGameSettings) {
    performSegue(withIdentifier: "startGameSchulteTableSegue", sender: data)
  }
  
  // MARK: - prepareSegue
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    self.presenter.prepare(for: segue, sender: sender)
  }
}

// MARK: - Switch IBActions

extension SchulteTableStartViewController {
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

// MARK: - UI Making Functions

extension SchulteTableStartViewController {
  
  // MARK: - makeView
  func makeView() {
    self.view.backgroundColor = UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 1)
  }
  
  // MARK: - navBarSetting
  func navBarSetting() {
    BarDesign().customizeNavBar(navigationController: self.navigationController, navigationItem: self.navigationItem)
    statsButton.image = UIImage(named: "Статистика")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
  }
  
  // MARK: - makeNavBarTitle
  func makeNavBarTitle() {
    let navBarTitleFont      = UIFont(name: "NotoSans-Bold", size: 23)!
    let navBarTitleFontColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 0.9)

    self.navigationItem.title = "Schulte Table"
    
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navBarTitleFont,
                                                                    NSAttributedString.Key.foregroundColor: navBarTitleFontColor]
  }
  
  // MARK: - makeRulesTitleLabel
  func makeRulesTitleLabel() {
    self.rulesTitleLabel.font                      = UIFont(name: "NotoSans-Bold", size: 17)
    self.rulesTitleLabel.textColor                 = UIColor(red: 0.152, green: 0.239, blue: 0.323, alpha: 0.9)
    self.rulesTitleLabel.text                      = "Rules"
    self.rulesTitleLabel.adjustsFontSizeToFitWidth = true
    self.rulesTitleLabel.numberOfLines             = 1
    self.rulesTitleLabel.minimumScaleFactor        = 0.5
  }
  
  // MARK: - makeRulesTextLabel
  func makeRulesTextLabel() {
    self.rulesTextLabel.font                      = UIFont(name: "NotoSans", size: 14)
    self.rulesTextLabel.textColor                 = UIColor(red: 0.153, green: 0.239, blue: 0.322, alpha: 0.8)
    self.rulesTextLabel.text                      = "Line 1\nLine 2\nLine 3\nLine 4\nLine 5\nLine 6"
    self.rulesTextLabel.adjustsFontSizeToFitWidth = true
    self.rulesTextLabel.numberOfLines             = 0
    self.rulesTextLabel.minimumScaleFactor        = 0.3
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
    self.mixingShadesOptionTitle.font      = UIFont(name: "NotoSans", size: 15)
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
  
  // MARK: - makeColorsCountSelectingButtons
  func makeColorsCountSelectingButtons() {
    let buttons = [self.oneColorButton, self.twoColorsButton, self.threeColorsButton]
    
    for (index, button) in buttons.enumerated() {
      /*
       * Цвет шрифта кнопки, которая была нажата
       * при прошлом заходе на этот экран делаем белой,
       * а остальные темными
       */
      if index + 1 == self.colorsCountChoose {
        button!.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.9), for: .normal)
      } else {
        button!.setTitleColor(UIColor(red: 0.153, green: 0.239, blue: 0.322, alpha: 0.9), for: .normal)
      }
      button!.titleLabel?.font                      = UIFont(name: "NotoSans", size: 13)
      button!.titleLabel?.minimumScaleFactor        = 0.1
      button!.titleLabel?.numberOfLines             = 1
      button!.titleLabel?.adjustsFontSizeToFitWidth = true
    }
  }
  
  // MARK: - makeColorsButtonsBackgroundView
  func makeColorsButtonsBackgroundView() {
//    let buttons       = [self.oneColorButton, self.twoColorsButton, self.threeColorsButton]
//    let choosedButton = buttons[self.colorsCountChoose - 1]! // Получили нажатую при прошлом заходе кнопку
//
//    // Получаем координаты выбранной в прошлый раз кнопки относительно settingBackgroundView, а не своего UIStackView
//    let settingBackgroundViewConvertedFrame = self.settingBackgroundView.convert(choosedButton.frame, from: choosedButton.superview)
//
//    // Сначала задаем размеры
//    self.colorsButtonsBackgroundView.frame.size.width  = 82
//    self.colorsButtonsBackgroundView.frame.size.height = 32
//
//    // И только затем устанавливаем координаты центра
//    self.colorsButtonsBackgroundView.center = CGPoint(x: settingBackgroundViewConvertedFrame.minX + choosedButton.frame.size.width / 2,
//                                                      y: settingBackgroundViewConvertedFrame.minY + choosedButton.frame.size.height / 2)
    
    self.colorsButtonsBackgroundView.shadowColor   = UIColor(red: 0.459, green: 0.608, blue: 0.98, alpha: 0.37).cgColor
    self.colorsButtonsBackgroundView.shadowOpacity = 1
    self.colorsButtonsBackgroundView.shadowRadius  = 5
    self.colorsButtonsBackgroundView.shadowOffset  = CGSize(width: 0, height: 5)
    
    self.colorsButtonsBackgroundView.backgroundColor = UIColor(red: 0.459, green: 0.608, blue: 0.98, alpha: 1)
    
    self.colorsButtonsBackgroundView.cornerRadius = 5
  }
  
  // MARK: - makeSettingsCollectionView
  func makeSettingsCollectionView() {
    self.settingsCollectionView.cornerRadius = 20
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
    SchulteTableStartViewController.levelNumberForSettingsCollectionViewCellsAppear = indexPath.row + 3
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

    // Changing chooseBackgroundView properties
    self.chooseBackgroundView.backgroundColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 1)
    self.chooseBackgroundView.borderWidth     = 0

    self.chooseViewLabel.text      = "Start"
    self.chooseViewLabel.textColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1)

    self.leftArrow.isHidden  = true
    self.rightArrow.isHidden = true

    // Making white arrow
    let nextArrow               = UIImageView()
    nextArrow.image             = UIImage(named: "БелаяСтрелка")
    nextArrow.frame.size.width  = 7
    nextArrow.frame.size.height = 12
    nextArrow.center            = rightArrow.center

    self.chooseBackgroundView.addSubview(nextArrow)

    self.cellDidDeselect(for: collectionView, selectedCellIndexPath: indexPath)
    
    // Set levelNumber
    self.levelNumber = indexPath.row + 1
    
    // Change settingsIsReady status
    self.settingsIsReady = true
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
