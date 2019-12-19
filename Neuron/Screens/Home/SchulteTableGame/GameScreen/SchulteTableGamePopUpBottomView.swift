//
//  SchulteTableGamePopUpBottomView.swift
//  Neuron
//
//  Created by Anar on 09.12.2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit
import PWSwitch

final class SchulteTableGamePopUpBottomView: UIView {
  var presenter: SchulteTableGamePopUpBottomViewPresenterDelegate?
  
  // MARK: - Properties
  @IBOutlet weak var arrow                       : UIImageView!
  @IBOutlet weak var chooseViewLabel             : UILabel!
  @IBOutlet weak var mixingShadesOptionTitle     : UILabel!
  @IBOutlet weak var mixingShadesSwitch          : PWSwitch!
  @IBOutlet weak var oneColorButton              : UIButton!
  @IBOutlet weak var twoColorsButton             : UIButton!
  @IBOutlet weak var threeColorsButton           : UIButton!
  @IBOutlet weak var colorsButtonsBackgroundView : UIView!
  @IBOutlet weak var settingsCollectionView      : UICollectionView!
  
  var mixingShades      : Bool! = false
  var colorsCountChoose : Int!
  var levelNumber       : Int = 1
  
  var settingsIsReady : Bool! = false
  
  let animationsDuration = 0.4
  
  var selectedCell: UICollectionViewCell? = nil
  
  // MARK: - init
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.start()
    contentMode = UIView.ContentMode.redraw
  }

  // MARK: - required init
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.start()
  }
  
  // MARK: - draw
  override func draw(_ rect: CGRect) {
    self.makeColorsButtonsBackgroundView()
  }

  // MARK: - start
  private func start() {
    self.getColorsCountChoose()
    
    self.setup()
    self.collectionViewSetting()
    self.makeSettingsCollectionView()
    self.makeArrow()
    self.makeChooseViewLabel()
    self.makeMixingShadesOptionTitle()
    self.makeMixingShadesSwitch()
    self.makeColorsCountSelectingButtons()
  }
  
  // MARK: - setup
  func setup() {
    let view = loadFromNib()
    view.frame = bounds
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    self.addSubview(view)
  }
  
  func loadFromNib() -> UIView {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: "SchulteTableGamePopUpBottomView", bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
    
    return view
  }
}

// MARK: - Colors Count Selecting

extension SchulteTableGamePopUpBottomView {
  
  // TODO: - Вынеси логику этих кнопок в презентер

  // MARK: - oneColorButton
  @IBAction func oneColorButton(_ sender: UIButton) {
    self.selectingAnimation(self.colorsCountChoose, 1)
    self.setColorsCountChoose(1)
    self.saveColorsButtonsBackgroundViewFrame()
  }

  // MARK: - twoColorsButton
  @IBAction func twoColorsButton(_ sender: UIButton) {
    self.selectingAnimation(self.colorsCountChoose, 2)
    self.setColorsCountChoose(2)
    self.saveColorsButtonsBackgroundViewFrame()
  }

  // MARK: - threeColorsButton
  @IBAction func threeColorsButton(_ sender: UIButton) {
    self.selectingAnimation(self.colorsCountChoose, 3)
    self.setColorsCountChoose(3)
    self.saveColorsButtonsBackgroundViewFrame()
  }
  
  // MARK: - selectingAnimation
  func selectingAnimation(_ position: Int, _ destination: Int) {
    guard position != destination else { return }
    
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
      self.colorsButtonsBackgroundView.center = buttonTo.center
    })
    
    UIView.animate(withDuration: self.animationsDuration, delay: self.animationsDuration, animations: {
      self.colorsButtonsBackgroundView.transform = CGAffineTransform(scaleX: 1, y: 1) // Увеличиваем форму
      
      UIView.transition(with: buttonTo, duration: self.animationsDuration / 2, options: .transitionCrossDissolve, animations: {
        buttonTo.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.9), for: .normal) // Меняем цвет шрифта текста той кнопки в которую пришли
      })
    })
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
}

// MARK: - Switch IBActions

extension SchulteTableGamePopUpBottomView {
  @IBAction func mixingShadesSwitchValueChanged(_ sender: PWSwitch) {
    self.presenter?.mixingShadesSwitchValueChanged(sender)
    self.mixingShades = sender.on
  }
  
  @IBAction func mixingShadesSwitchTouchDown(_ sender: PWSwitch) {
    self.presenter?.mixingShadesSwitchTouchDown(sender)
  }
  
  @IBAction func mixingShadesSwitchTouchUpInside(_ sender: PWSwitch) {
    self.presenter?.mixingShadesSwitchTouchUpInside(sender)
  }
  
  @IBAction func mixingShadesSwitchTouchUpOutside(_ sender: PWSwitch) {
    self.presenter?.mixingShadesSwitchTouchUpOutside(sender)
  }
  
  @IBAction func mixingShadesSwitchTouchDragExit(_ sender: PWSwitch) {
    self.presenter?.mixingShadesSwitchTouchDragExit(sender)
  }
}

// MARK: - UI Making Functions

extension SchulteTableGamePopUpBottomView {
  
  // MARK: - makeSettingsCollectionView
  func makeSettingsCollectionView() {
    self.settingsCollectionView.backgroundColor = .clear
    self.settingsCollectionView.cornerRadius = 20
    
    let layout = UICollectionViewFlowLayout()
    
    layout.sectionInset            = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
    layout.minimumLineSpacing      = 7
    layout.minimumInteritemSpacing = 10
    layout.scrollDirection         = .horizontal
    
    self.settingsCollectionView?.collectionViewLayout = layout
  }

  // MARK: - makeArrow
  func makeArrow() {
    self.arrow.transform = self.arrow.transform.rotated(by: .pi)
  }
  
  // MARK: - rotateArrow
  func rotateArrow() {
    UIView.animate(withDuration: 0.5, animations: {
       self.arrow.transform = self.arrow.transform.rotated(by: -.pi / 2)
    })
  }

  // MARK: - makeChooseViewLabel
  func makeChooseViewLabel() {
    self.chooseViewLabel.textColor = UIColor(red: 0.153, green: 0.239, blue: 0.322, alpha: 1)
    self.chooseViewLabel.font      = UIFont(name: "NotoSans-Bold", size: 20)
  }

  // MARK: - makeMixingShadesOptionTitle
  func makeMixingShadesOptionTitle() {
    self.mixingShadesOptionTitle.font      = UIFont(name: "NotoSans", size: 15)
    self.mixingShadesOptionTitle.textColor = UIColor(red: 0.153, green: 0.239, blue: 0.322, alpha: 0.9)
    self.mixingShadesOptionTitle.text      = "Mixing shades"
  }
  
  // MARK: - changeChooseViewLabel
  func changeChooseViewLabel() {
    self.chooseViewLabel.text = "Start"
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
  
  // MARK: - makeColorsButtonsBackgroundView
  func makeColorsButtonsBackgroundView() {
    let buttons = [self.oneColorButton, self.twoColorsButton, self.threeColorsButton]
    
    self.colorsButtonsBackgroundView.frame = buttons[self.colorsCountChoose - 1]!.frame
    
    self.colorsButtonsBackgroundView.shadowColor   = UIColor(red: 0.459, green: 0.608, blue: 0.98, alpha: 0.37).cgColor
    self.colorsButtonsBackgroundView.shadowOpacity = 1
    self.colorsButtonsBackgroundView.shadowRadius  = 5
    self.colorsButtonsBackgroundView.shadowOffset  = CGSize(width: 0, height: 5)
    
    self.colorsButtonsBackgroundView.backgroundColor = UIColor(red: 0.459, green: 0.608, blue: 0.98, alpha: 1)
    
    self.colorsButtonsBackgroundView.cornerRadius = 5
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
      button!.titleLabel!.font = UIFont(name: "NotoSans-Bold", size: 13)
      button!.frame.size = CGSize(width: 92, height: 32)
    }
  }
}

// MARK: - UICollectionView functions

extension SchulteTableGamePopUpBottomView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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

    self.changeChooseViewLabel()
    self.rotateArrow()
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

