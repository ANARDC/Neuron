//
//  SchulteTableGamePresenter.swift
//  Neuron
//
//  Created by Anar on 21.11.2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import Foundation
import UIKit

protocol SchulteTableGamePresenterDelegate {
  func viewDidload()
}

final class SchulteTableGamePresenter: SchulteTableGamePresenterDelegate {
  var view: SchulteTableGameViewControllerDelegate?
  
  init(view: SchulteTableGameViewControllerDelegate) {
    self.view = view
  }
  
  // MARK: - viewDidload
  func viewDidload() {
    self.view?.makeRestartButtonImage()
    self.view?.makeTimerLabel()
    self.view?.makeTableCollectionViewSize()
    self.view?.makeTableCollectionView()

    self.view?.collectionViewSetting()
    
    self.configureGame()
  }
  
  // MARK: - configureGame
  func configureGame() {
    let smashedCellsCount = self.getSmashedCellsCount()
    let colorsDict        = self.getColorsArray(smashedCellsCount)
    let cellsNumbers      = self.getCellsNumbers()
    
    self.view!.tableCollectionViewCellsData = self.getTableCollectionViewCellsData(cellsNumbers, colorsDict.map{ $0.0 }, colorsDict.map{ $0.1 })
  }
  
  // MARK: - getSmashedCellsCount
  func getSmashedCellsCount() -> [Int] {
    let cellsCount = [1: 9, 2: 16, 3: 25, 4: 36, 5: 49, 6: 64, 7: 81]
    let levelNumber = self.view!.settingsData.levelNumber
    let colorsCount = self.view!.settingsData.colorsCount
    
    var smashedCount = [Int]()
    
    for _ in 1..<self.view!.settingsData.colorsCount {
      smashedCount.append(Int(cellsCount[levelNumber]! / colorsCount))
    }
    
    smashedCount.append(cellsCount[levelNumber]! - smashedCount.reduce(0, +))
    
    return smashedCount
  }
  
  // MARK: - getColorsArray
  func getColorsArray(_ smashedCellsCount: [Int]) -> [(UIColor, UIColor)] {
    let colors = [UIColor(red: 0.459, green: 0.608, blue: 0.98, alpha: 1),  // Blue
                  UIColor(red: 0.315, green: 0.788, blue: 0.22, alpha: 1),  // Green
                  UIColor(red: 0.992, green: 0.314, blue: 0.314, alpha: 1)] // Red
    var colorsArray = [(UIColor, UIColor)]() // [(backgroundColor: labelTextColor)]
    
    for (index, count) in smashedCellsCount.enumerated() {
      for _ in 0..<count {
        colorsArray.append((colors[index], UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 1)))
      }
    }
    
    return colorsArray.shuffled()
  }
  
  // MARK: - getCellsNumbers
  func getCellsNumbers() -> [Int] {
    let cellsCount   = [1: 9, 2: 16, 3: 25, 4: 36, 5: 49, 6: 64, 7: 81]
    let cellsNumbers = Array(1...cellsCount[self.view!.settingsData.levelNumber]!).shuffled()
    
    return cellsNumbers
  }
  
  // MARK: - getTableCollectionViewCellsData
  func getTableCollectionViewCellsData(_ cellsNumbers: [Int], _ cellsBackgroundColor: [UIColor], _ cellsLabelsTextColor: [UIColor]) -> [tableCollectionViewCellData] {
    var resultTableCollectionViewCellsData = [tableCollectionViewCellData]()
    
    let cellsCount   = [1: 9, 2: 16, 3: 25, 4: 36, 5: 49, 6: 64, 7: 81]
    
    for i in 0..<cellsCount[self.view!.settingsData.levelNumber]! {
      resultTableCollectionViewCellsData.append(tableCollectionViewCellData(backgroundColor: cellsBackgroundColor[i],
                                                                            labelTextColor: cellsLabelsTextColor[i],
                                                                            labelText: String(cellsNumbers[i])))
    }
    
    return resultTableCollectionViewCellsData
  }
}

// MARK: - tableCollectionViewCellData
struct tableCollectionViewCellData {
  let backgroundColor : UIColor
  let labelTextColor  : UIColor
  let labelText       : String
}
