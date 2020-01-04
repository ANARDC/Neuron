//
//  ViewController.swift
//  Neuron
//
//  Created by Anar on 02.01.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import UIKit

// MARK: - protocol
protocol LacesStartViewControllerDelegate {
  var settingsIsReady: Bool { get }
  
  func goToGameScreen()
  
  func hideTabBar()
  func navBarSetting()
  func makeNavBarTitle()
  func makeRulesTitleLabel()
  func makeRulesTextView()
  func makeSeparatorView()
  func makeWarningTextView()
  func raiseTextViewsTextContent()
  func makeLevelsTitleLabel()
  func makeLevelsCollectionView()
  func makeChooseBackgroundView()
  func makeChooseViewLabel()
}

// MARK: - class
final class LacesStartViewController: UIViewController, LacesStartViewControllerDelegate {
  var configurator : LacesStartConfigurator!
  var presenter    : LacesStartPresenterDelegate!
  
  let animationsDuration = 0.4
  
  var selectedCell: UICollectionViewCell!
  
  @IBOutlet weak var statsButton : UIBarButtonItem!
  
  @IBOutlet weak var rulesTitleLabel : UILabel!
  @IBOutlet weak var rulesTextView   : UITextView!
  @IBOutlet weak var separatorView   : UIView!
  @IBOutlet weak var warningTextView : UITextView!
  
  @IBOutlet weak var levelsTitleLabel     : UILabel!
  @IBOutlet weak var levelsCollectionView : UICollectionView!
  
  @IBOutlet weak var chooseBackgroundView : UIView!
  @IBOutlet weak var leftArrow            : UIImageView!
  @IBOutlet weak var rightArrow           : UIImageView!
  @IBOutlet weak var chooseViewLabel      : UILabel!
  
  static var levelAccessState : LacesLevelsAccessState = .open
  static var levelNumber      : Int = 0
  var levelNumber             : Int!
  
  var settingsIsReady = false
}

enum LacesLevelsAccessState {
  case open
  case close
}

// MARK: - Life Cycle

extension LacesStartViewController {
  
  // MARK: - viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configurator = LacesStartConfiguratorImplementation(self)
    self.configurator.configure(self)
    self.presenter.viewDidLoad()
  }
  
  // MARK: - viewWillAppear
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.presenter.viewWillAppear()
  }
  
  // MARK: - viewDidLayoutSubviews
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.presenter.viewDidLayoutSubviews()
  }
}

// MARK: - Start Game

extension LacesStartViewController {
  
  // MARK: - startGame
  @IBAction func startGame(_ sender: UITapGestureRecognizer) {
    self.presenter.startGame()
  }
  
  // MARK: - goToGameScreen
  func goToGameScreen() {
    performSegue(withIdentifier: "startLacesGameSegue", sender: nil)
  }
}

// MARK: - UI Making Functions

extension LacesStartViewController {
  
  // MARK: - hideTabBar
  func hideTabBar() {
     self.tabBarController?.tabBar.isHidden = true
  }
  
  // MARK: - navBarSetting
  func navBarSetting() {
    self.statsButton.image = UIImage(named: "Статистика")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
  }
  
  // MARK: - makeNavBarTitle
  func makeNavBarTitle() {
    let navBarTitleFont      = UIFont(name: "NotoSans-Bold", size: 23)!
    let navBarTitleFontColor = UIColor(red: 0.15, green: 0.24, blue: 0.32, alpha: 0.9)

    self.navigationItem.title = "Laces"
    
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navBarTitleFont,
                                                                    NSAttributedString.Key.foregroundColor: navBarTitleFontColor]
  }
  
  // MARK: - makeRulesTitleLabel
  func makeRulesTitleLabel() {
    self.rulesTitleLabel.font      = UIFont(name: "NotoSans-Bold", size: 17)
    self.rulesTitleLabel.textColor = UIColor(red: 0.152, green: 0.239, blue: 0.323, alpha: 0.9)
    self.rulesTitleLabel.text      = "Rules"
  }
  
  // MARK: - makeRulesTextView
  func makeRulesTextView() {
    self.rulesTextView.isSelectable    = false
    self.rulesTextView.isEditable      = false
    self.rulesTextView.backgroundColor = .clear
    self.rulesTextView.textColor       = UIColor(red: 0.153, green: 0.239, blue: 0.322, alpha:  0.8)
    self.rulesTextView.font            = UIFont(name: "NotoSans", size: 14)
    self.rulesTextView.text            =
    "For a limited time, you will need to restore the position of the laces in the order in which they were originally presented. Grids from 4×4 to 8×8 are available. To unlock the enlarged grids, successfully complete the last available grid with at least one star laces."
  }
  
  // MARK: - makeSeparatorView
  func makeSeparatorView() {
    self.separatorView.backgroundColor = UIColor(red: 0.49, green: 0.545, blue: 0.592, alpha: 1)
  }
  
  // MARK: - makeWarningTextView
  func makeWarningTextView() {
    self.warningTextView.isSelectable    = false
    self.warningTextView.isEditable      = false
    self.warningTextView.backgroundColor = .clear
    self.warningTextView.textColor       = UIColor(red: 0.153, green: 0.239, blue: 0.322, alpha:  0.8)
    self.warningTextView.font            = UIFont(name: "NotoSans", size: 14)
    self.warningTextView.text            = "Please do not take screenshots and other tricks to pass. So you are only deceiving yourself!"
  }
  
  // MARK: - raiseTextViewsTextContent
  func raiseTextViewsTextContent() {
    self.rulesTextView.setContentOffset(.zero, animated: false)
    self.warningTextView.setContentOffset(.zero, animated: false)
  }
  
  // MARK: - levelsTitleLabel
  func makeLevelsTitleLabel() {
    self.levelsTitleLabel.font     = UIFont(name: "NotoSans-Bold", size: 17)
    self.levelsTitleLabel.textColor = UIColor(red: 0.152, green: 0.239, blue: 0.323, alpha: 0.9)
    self.levelsTitleLabel.text      = "Levels"
  }
  
  // MARK: - makeLevelsCollectionView
  func makeLevelsCollectionView() {
    self.levelsCollectionView.delegate                       = self
    self.levelsCollectionView.dataSource                     = self
    self.levelsCollectionView.backgroundColor                = self.view.backgroundColor
    self.levelsCollectionView.showsHorizontalScrollIndicator = false
    
    let collectionViewLayout = levelsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout

    collectionViewLayout?.sectionInset       = UIEdgeInsets(top: 0, left: 20, bottom: 30, right: 20)
    collectionViewLayout?.minimumLineSpacing = 7
    collectionViewLayout?.scrollDirection    = .horizontal
    collectionViewLayout?.invalidateLayout()
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

// MARK: - UICollectionViewDataSource

extension LacesStartViewController: UICollectionViewDataSource {
  
  // MARK: - numberOfItemsInSection
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    6
  }
  
  // MARK: - cellForItemAt
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    /*
     * Последняя ячейка пока что
     * всегда закрыта, потом сделаю
     * с уровнем доступа как в фруктах
     */
    // TODO: Реализовать уровень доступа
    LacesStartViewController.levelAccessState = indexPath.row != collectionView.numberOfItems(inSection: 0) - 1 ? .open : .close
    LacesStartViewController.levelNumber = indexPath.row + 4
    self.levelsCollectionView.register(LacesStartLevelsCollectionViewCell.self, forCellWithReuseIdentifier: "level\(indexPath.row)")
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "level\(indexPath.row)", for: indexPath)
    return cell
  }
}

// MARK: - UICollectionViewDelegate

extension LacesStartViewController: UICollectionViewDelegate {
  
  // MARK: - didSelectItemAt
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath), indexPath.row != collectionView.numberOfItems(inSection: 0) - 1 else { return }

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
    self.levelNumber = indexPath.row
    
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


// MARK: - UICollectionViewDelegateFlowLayout

extension LacesStartViewController: UICollectionViewDelegateFlowLayout {
  
  // MARK: - sizeForItemAt
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    CGSize(width: 86, height: 48)
  }
}
