//
//  PopUpBottomView.swift
//  Neuron
//
//  Created by Anar on 22/09/2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

final class PopUpBottomView: UIView {
  var presenter: FruitsGamePresenterDelegate?
  private var accessLevel: Int!
  
  // MARK: - Properties
  @IBOutlet weak var levelsCollectionView: UICollectionView!
  @IBOutlet weak var topLabel: UILabel!
  @IBOutlet weak var chooseBackgroundView: UIView!
  @IBOutlet weak var leftArrow: UIImageView!
  @IBOutlet weak var rightArrow: UIImageView!
  @IBOutlet weak var chooseViewLabel: UILabel!
  
  var choosenLevelNumber = 1
  var selectedCell: UICollectionViewCell? = nil
  let animationsDuration = 0.4
  
  // MARK: - init
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.start()
  }
  
  // MARK: - required init
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.start()
  }
  
  // MARK: - start
  private func start() {
    self.setup()
    self.collectionViewSetting()
    self.chooseButtonAppearance()
    self.getAccessLevel()
  }
  
  // MARK: - startGame IBAction
  @IBAction func starsGame(_ sender: UITapGestureRecognizer) {
    guard chooseBackgroundView.backgroundColor == UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 1) else { return }
    self.presenter!.startNewGame(choosenLevelNumber: choosenLevelNumber)
  }
}

// MARK: - getAccessLevel()

extension PopUpBottomView {
  
  func getAccessLevel() {
    let userDefaults = UserDefaults.standard
    let userDefaultsFruitsGameAccessLevelKey = "fruitsGameAccessLevel"
    
    self.accessLevel = userDefaults.integer(forKey: userDefaultsFruitsGameAccessLevelKey)
  }
}

// MARK: - View appearing

extension PopUpBottomView {
  
  // MARK: - loadFromNib
  func loadFromNib() -> UIView {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: "BottomView", bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
    
    return view
  }
  
  // MARK: - setup
  func setup() {
    let view = loadFromNib()
    view.frame = bounds
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    self.addSubview(view)
  }
}

// MARK: - chooseButtonAppearance
extension PopUpBottomView {
  func chooseButtonAppearance() {
    self.chooseBackgroundView.backgroundColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1)
    self.chooseBackgroundView.shadowColor     = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
    self.chooseBackgroundView.shadowOpacity   = 1
    self.chooseBackgroundView.shadowRadius    = 14
    self.chooseBackgroundView.shadowOffset    = CGSize(width: 0, height: 11)
    self.chooseBackgroundView.cornerRadius    = 8
    self.chooseBackgroundView.borderWidth     = 2
    self.chooseBackgroundView.borderColor     = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 1).cgColor
    
    (self.leftArrow.image, self.rightArrow.image) = (UIImage(named: "Далее"), UIImage(named: "Далее"))
    
    self.chooseViewLabel.text      = "Choose a level"
    self.chooseViewLabel.textColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 1)
    self.chooseViewLabel.font      = UIFont(name: "NotoSans-Bold", size: 20)
  }
}

// MARK: - CollectionView

extension PopUpBottomView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  // MARK: - numberOfItemsInSection
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.accessLevel
  }
  
  // MARK: - cellForItemAt
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    FruitsStartViewController.levelNumber = indexPath.row + 1
    levelsCollectionView.register(LevelsCollectionViewCell.self, forCellWithReuseIdentifier: "level\(indexPath.row)")
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "level\(indexPath.row)", for: indexPath) as! LevelsCollectionViewCell
    return cell
  }
  
  // MARK: - levelsCollectionView Delegate And DataSource
  func collectionViewSetting() {
    levelsCollectionView.delegate = self
    levelsCollectionView.dataSource = self
    
//    levelsCollectionView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 0.85)
    levelsCollectionView.backgroundColor = .clear
  }
  
  // MARK: - Levels Collection Viewing
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch indexPath.row + 1 {
    case ...20:
      return CGSize(width: 86, height: 48)
    case 21...30:
      return CGSize(width: 100, height: 48)
    case 31...40:
      return CGSize(width: 114, height: 48)
    default:
      return CGSize(width: 128, height: 48)
    }
  }
  
  // MARK: - didSelectItemAt
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath) else { return }
    
    let animation0 = CABasicAnimation(keyPath: "borderColor")
    animation0.fromValue = cell.borderColor
    animation0.toValue = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 1).cgColor
    animation0.duration = animationsDuration
    cell.layer.add(animation0, forKey: animation0.keyPath)
    
    let animation1 = CABasicAnimation(keyPath: "borderWidth")
    animation1.fromValue = cell.borderWidth
    animation1.toValue = 2
    animation1.duration = animationsDuration
    cell.layer.add(animation1, forKey: animation1.keyPath)
    
    let animation2 = CABasicAnimation(keyPath: "shadowOpacity")
    animation2.fromValue = cell.shadowOpacity
    animation2.toValue = 0
    animation2.duration = animationsDuration
    cell.layer.add(animation2, forKey: animation2.keyPath)
    
    cell.borderColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 1).cgColor
    cell.borderWidth = 2
    cell.shadowOpacity = 0
    
    chooseBackgroundView.backgroundColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 1)
    chooseBackgroundView.borderWidth = 0
    
    chooseViewLabel.text = "Start"
    chooseViewLabel.textColor = UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1)
    
    leftArrow.isHidden = true
    rightArrow.isHidden = true
    
    let nextArrow = UIImageView()
    nextArrow.image = UIImage(named: "БелаяСтрелка")
    nextArrow.frame = CGRect(x: 283, y: 18, width: 7, height: 12)
    
    chooseBackgroundView.addSubview(nextArrow)
    
    choosenLevelNumber = indexPath.row + 1
    
    cellDidDeselect(for: collectionView, selectedCellIndexPath: indexPath)
  }
  
  // MARK: - cellDidDeselect
  func cellDidDeselect(for collectionView: UICollectionView, selectedCellIndexPath indexPath: IndexPath) {
    if let selectedCell = selectedCell {
      guard collectionView.indexPath(for: selectedCell) != indexPath else { return }
      
      let SCAnimation0 = CABasicAnimation(keyPath: "borderColor")
      SCAnimation0.fromValue = selectedCell.borderColor
      SCAnimation0.toValue = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
      SCAnimation0.duration = animationsDuration
      selectedCell.layer.add(SCAnimation0, forKey: SCAnimation0.keyPath)
      
      let SCAnimation1 = CABasicAnimation(keyPath: "borderWidth")
      SCAnimation1.fromValue = selectedCell.borderWidth
      SCAnimation1.toValue = 1
      SCAnimation1.duration = animationsDuration
      selectedCell.layer.add(SCAnimation1, forKey: SCAnimation1.keyPath)
      
      let SCAnimation2 = CABasicAnimation(keyPath: "shadowOpacity")
      SCAnimation2.fromValue = selectedCell.shadowOpacity
      SCAnimation2.toValue = 1
      SCAnimation2.duration = animationsDuration
      selectedCell.layer.add(SCAnimation2, forKey: SCAnimation2.keyPath)
      
      selectedCell.borderColor = UIColor(red: 0.9, green: 0.93, blue: 0.93, alpha: 1).cgColor
      selectedCell.borderWidth = 1
      selectedCell.shadowOpacity = 1
    }
    
    selectedCell = collectionView.cellForItem(at: indexPath)
  }
}
