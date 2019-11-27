//
//  SchulteTableGameViewController.swift
//  Neuron
//
//  Created by Anar on 21.11.2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit

protocol SchulteTableGameViewControllerDelegate {
  var settingsData : SchulteTableGameSettings! { get }
  
  func generateRandomUniqueNumbers()
  
  func makeRestartButtonImage()
  func makeTimerLabel()
  func makeTableCollectionViewSize()
  func makeTableCollectionView()

  func collectionViewSetting()
}

final class SchulteTableGameViewController: UIViewController, SchulteTableGameViewControllerDelegate {
  var configurator : SchulteTableGameConfigurator!
  var presenter    : SchulteTableGamePresenterDelegate!
  
  var settingsData : SchulteTableGameSettings!
  
  static var cellLabelText : String!
  
  var cellsNumbers: [Int]!
  
  @IBOutlet weak var timerLabel          : UILabel!
  @IBOutlet weak var restartButton       : UIBarButtonItem!
  @IBOutlet weak var tableCollectionView : UICollectionView!
  @IBOutlet var stars                    : [UIImageView]!
  
  @IBOutlet weak var tableCollectionViewTrailingConstraint: NSLayoutConstraint!
  @IBOutlet weak var tableCollectionVIewLeadingConstraint: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configurator = SchulteTableGameConfiguratorImplementation(self)
    self.configurator.configure(self)
    self.presenter.viewDidload()
  }
}

// MARK: - UI Making Functions

extension SchulteTableGameViewController {
  
  // MARK: - makeRestartButtonImage
  func makeRestartButtonImage() {
    self.restartButton.image = #imageLiteral(resourceName: "Рестарт").withRenderingMode(.alwaysOriginal)
  }
  
  // MARK: - makeTimerLabel
  func makeTimerLabel() {
    self.timerLabel.textColor = UIColor(red: 0.153, green: 0.239, blue: 0.322, alpha: 0.9)
  }

  // MARK: - makeTableCollectionViewSize
  func makeTableCollectionViewSize() {
    switch UIScreen.main.bounds.height {
    case 568: // iPhone SE
      self.tableCollectionVIewLeadingConstraint.constant  = 0
      self.tableCollectionViewTrailingConstraint.constant = 0
    default:
      return
    }
  }
  
  // MARK: - makeTableCollectionView
  func makeTableCollectionView() {
    self.tableCollectionView.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
  }
}

// MARK: - UICollectionView functions

extension SchulteTableGameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let cellsCount = [1: 9, 2: 16, 3: 25, 4: 36, 5: 49, 6: 64, 7: 81]
    return cellsCount[self.settingsData.levelNumber]!
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    SchulteTableGameViewController.cellLabelText = String(self.cellsNumbers[indexPath.row])
    self.tableCollectionView.register(SchulteTableGameTableCollectionViewCell.self, forCellWithReuseIdentifier: "cell\(indexPath.row)")
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell\(indexPath.row)", for: indexPath)
    return cell
  }
  
  // MARK: - tableCollectionView Delegate And DataSource
  func collectionViewSetting() {
    self.tableCollectionView.delegate   = self
    self.tableCollectionView.dataSource = self
  }
  
  // MARK: - Cells Size
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellsDimension: [Int: CGFloat] = [1: 3, 2: 4, 3: 5, 4: 6, 5: 7, 6: 8, 7: 9]
    let tableCollectionViewDimension   = self.tableCollectionView.frame.size.width
    let currentLevelNumber             = self.settingsData.levelNumber
    let currentLevelCellsDimension     = tableCollectionViewDimension / cellsDimension[currentLevelNumber]! - 0.1
    
    return CGSize(width: currentLevelCellsDimension, height: currentLevelCellsDimension)
  }
  
  // MARK: - generateRandomUniqueNumbers
  func generateRandomUniqueNumbers() {
    var numbers = [Int]()
    let cellsCount = [1: 9, 2: 16, 3: 25, 4: 36, 5: 49, 6: 64, 7: 81]
    
    for _ in 0..<cellsCount[self.settingsData.levelNumber]! {
      var n: Int
      repeat {
        n = Int(arc4random_uniform(UInt32(cellsCount[self.settingsData.levelNumber]!))) + 1
      } while numbers.contains(n)
      numbers.append(n)
    }
    
    self.cellsNumbers = numbers
  }
}
