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
  
  var tableCollectionViewCellsData             : [tableCollectionViewCellData]! { get set }
  var tableCollectionViewCellsDataInRightOrder : [tableCollectionViewCellData]! { get set }
  
  func makeRestartButtonImage()
  func makeTimerLabel()
  func makeTableCollectionViewSize()
  func makeTableCollectionView()
  func makeNavBarTitle(for cellData: tableCollectionViewCellData)
  
  func collectionViewSetting()
}

final class SchulteTableGameViewController: UIViewController, SchulteTableGameViewControllerDelegate {
  var configurator : SchulteTableGameConfigurator!
  var presenter    : SchulteTableGamePresenterDelegate!
  
  var settingsData : SchulteTableGameSettings!
  
  var tableCollectionViewCellsData              : [tableCollectionViewCellData]!
  var tableCollectionViewCellsDataInRightOrder  : [tableCollectionViewCellData]!
  static var currentTableCollectionViewCellData : tableCollectionViewCellData!
  
  var currentCellIndex = 0
  
  var cellsNumbers : [Int]!
  
  @IBOutlet weak var timerLabel          : UILabel!
  @IBOutlet weak var restartButton       : UIBarButtonItem!
  @IBOutlet weak var tableCollectionView : UICollectionView!
  @IBOutlet var stars                    : [UIImageView]!
  
  @IBOutlet weak var tableCollectionViewTrailingConstraint : NSLayoutConstraint!
  @IBOutlet weak var tableCollectionViewLeadingConstraint  : NSLayoutConstraint!
}

// MARK: - Life Cycle

extension SchulteTableGameViewController {
  
  // MARK: - viewDidLoad
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
      self.tableCollectionViewLeadingConstraint.constant  = 0
      self.tableCollectionViewTrailingConstraint.constant = 0
    default:
      return
    }
  }
  
  // MARK: - makeTableCollectionView
  func makeTableCollectionView() {
    self.tableCollectionView.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
  }
  
  // MARK: - makeNavBarTitle
  func makeNavBarTitle(for cellData: tableCollectionViewCellData) {
    let colors = ["blue": UIColor(red: 0.459, green: 0.608, blue: 0.98, alpha: 1),
                  "green": UIColor(red: 0.315, green: 0.788, blue: 0.22, alpha: 1),
                  "red": UIColor(red: 0.992, green: 0.314, blue: 0.314, alpha: 1)]
    
    let blueShades = [UIColor(red: 0.784, green: 0.839, blue: 0.967, alpha: 1),
                      UIColor(red: 0.176, green: 0.612, blue: 0.859, alpha: 1),
                      UIColor(red: 0.459, green: 0.608, blue: 0.98, alpha: 1),
                      UIColor(red: 0.358, green: 0.467, blue: 0.739, alpha: 1)]
    
    let greenShades = [UIColor(red: 0.788, green: 0.93, blue: 0.765, alpha: 1),
                       UIColor(red: 0.435, green: 0.812, blue: 0.592, alpha: 1),
                       UIColor(red: 0.315, green: 0.788, blue: 0.22, alpha: 1),
                       UIColor(red: 0.129, green: 0.588, blue: 0.325, alpha: 1)]
    
    let redShades = [UIColor(red: 0.979, green: 0.82, blue: 0.82, alpha: 1),
                     UIColor(red: 1, green: 0.451, blue: 0.451, alpha: 1),
                     UIColor(red: 0.992, green: 0.314, blue: 0.314, alpha: 1),
                     UIColor(red: 0.801, green: 0.265, blue: 0.265, alpha: 1)]
    
    var navBarTitleFontColor: UIColor!
    
    /*
     * Цвет текста title у навбара
     * не должен иметь оттенков,
     * а только яркие основные цвета
     */
    
    if blueShades.contains(cellData.backgroundColor) {
      navBarTitleFontColor = colors["blue"]!
    } else if greenShades.contains(cellData.backgroundColor) {
      navBarTitleFontColor = colors["green"]!
    } else if redShades.contains(cellData.backgroundColor) {
      navBarTitleFontColor = colors["red"]!
    }
    
    let navBarTitleFont = UIFont(name: "NotoSans-Bold", size: 23)!

    self.navigationItem.title = "Looking for \(cellData.labelText)"
    
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: navBarTitleFont,
                                                                    NSAttributedString.Key.foregroundColor: navBarTitleFontColor!]
  }
  
  // MARK: - changeTimerLabel
  func changeTimerLabel() {
    self.timerLabel.text      = "Wrong!"
    self.timerLabel.textColor = UIColor(red: 0.922, green: 0.341, blue: 0.341, alpha: 0.9)
  }
  
  // MARK: - highlight
  func highlight(cellWithText markedCellText: String) {
    self.tableCollectionView.backgroundColor = self.tableCollectionView.backgroundColor?.withAlphaComponent(0.25)
    
    self.tableCollectionView.visibleCells.forEach { (cell) in
      /*
       * Сначала у каждой ячейки понижаем
       * альфа фонового цвета и
       * цвета границы
       */
      
      cell.backgroundColor = cell.backgroundColor?.withAlphaComponent(0.25)
      cell.borderColor     = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.25).cgColor
      
      cell.subviews.forEach { (view) in
        guard type(of: view) == UILabel.self else { return }
        
        /*
         * Для всех ячеек
         * уменьшаем альфа у лэйбла
         */
        
        let label       = view as! UILabel
        label.textColor = label.textColor.withAlphaComponent(0.25)
        
        guard label.text! == markedCellText else { return }
        
        /*
         * А затем для нужной восстанавливаем
         * значения альфа у фонового цвета и
         * цвета текста лэйбла
         */
        
        cell.backgroundColor = cell.backgroundColor?.withAlphaComponent(1)
        label.textColor      = label.textColor.withAlphaComponent(1)
      }
    }
  }
}

// MARK: - UICollectionView functions

extension SchulteTableGameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  // MARK: - tableCollectionView Delegate And DataSource
  func collectionViewSetting() {
    self.tableCollectionView.delegate   = self
    self.tableCollectionView.dataSource = self
  }
  
  // MARK: - Number Of Items In Section
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let cellsCount = [1: 9, 2: 16, 3: 25, 4: 36, 5: 49, 6: 64, 7: 81]
    return cellsCount[self.settingsData.levelNumber]!
  }
  
  // MARK: - Cell For Item At
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    SchulteTableGameViewController.currentTableCollectionViewCellData = self.tableCollectionViewCellsData[indexPath.row]
    self.tableCollectionView.register(SchulteTableGameTableCollectionViewCell.self, forCellWithReuseIdentifier: "cell\(indexPath.row)")
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell\(indexPath.row)", for: indexPath)
    return cell
  }
  
  // MARK: - Cells Size
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellsDimension: [Int: CGFloat] = [1: 3, 2: 4, 3: 5, 4: 6, 5: 7, 6: 8, 7: 9]
    let tableCollectionViewDimension   = self.tableCollectionView.frame.size.width
    let currentLevelNumber             = self.settingsData.levelNumber
    let currentLevelCellsDimension     = tableCollectionViewDimension / cellsDimension[currentLevelNumber]! - 0.1
    
    return CGSize(width: currentLevelCellsDimension, height: currentLevelCellsDimension)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let cell = collectionView.cellForItem(at: indexPath) as! SchulteTableGameTableCollectionViewCell
    
    cell.subviews.forEach { (view) in
      guard type(of: view) == UILabel.self else { return }
      
      let label = view as! UILabel
      
      switch label.text! == self.tableCollectionViewCellsDataInRightOrder[self.currentCellIndex].labelText {
      case true:
        self.currentCellIndex += 1
        
        // Обрабатываем indexOutOfRange
        let cellsCount = [1: 9, 2: 16, 3: 25, 4: 36, 5: 49, 6: 64, 7: 81]
        guard self.currentCellIndex != cellsCount[self.settingsData.levelNumber] else { return }
        
        self.makeNavBarTitle(for: self.tableCollectionViewCellsDataInRightOrder[self.currentCellIndex])
      case false:
        self.changeTimerLabel()
        self.highlight(cellWithText: self.tableCollectionViewCellsDataInRightOrder[self.currentCellIndex].labelText)
      }
    }
  }
}
