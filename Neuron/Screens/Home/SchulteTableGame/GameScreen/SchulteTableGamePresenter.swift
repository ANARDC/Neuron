//
//  SchulteTableGamePresenter.swift
//  Neuron
//
//  Created by Anar on 21.11.2019.
//  Copyright © 2019 Commodo. All rights reserved.
//

import UIKit
import PWSwitch

protocol SchulteTableGamePresenterDelegate {
  func viewDidload()
  func viewWillAppear()
  func willMove()
  
  func restart(from state: SchulteTableGamePresenter.GameViewState)
}

protocol SchulteTableGamePopUpBottomViewPresenterDelegate {
  func startGame(data: SchulteTableGameSettings)

  func mixingShadesSwitchValueChanged(_ sender: PWSwitch)
  func mixingShadesSwitchTouchDown(_ sender: PWSwitch)
  func mixingShadesSwitchTouchUpInside(_ sender: PWSwitch)
  func mixingShadesSwitchTouchUpOutside(_ sender: PWSwitch)
  func mixingShadesSwitchTouchDragExit(_ sender: PWSwitch)
}

final class SchulteTableGamePresenter: SchulteTableGamePresenterDelegate {
  var view: SchulteTableGameViewControllerDelegate?
  
  init(view: SchulteTableGameViewControllerDelegate) {
    self.view = view
  }
  
  // MARK: - viewDidload
  func viewDidload() {
    self.configureGame()
    
    self.view?.makeRestartButtonImage()
    self.view?.makeTimerLabel()
    self.view?.makeTableCollectionViewSize()
    self.view?.makeTableCollectionView()
    self.view?.makeNavBarTitle(for: self.view!.tableCollectionViewCellsDataInRightOrder.first!)
    self.view?.startTimer()

    self.view?.collectionViewSetting()
  }
  
  // MARK: - viewWillAppear
  func viewWillAppear() {
    self.view?.makeNavBarTitle(for: self.view!.tableCollectionViewCellsDataInRightOrder.first!)
  }
  
  // MARK: - willMove
  func willMove() {
    self.view?.returnNavBarTitle()
  }
  
  // MARK: - configureGame
  func configureGame() {
    let smashedCellsCount = self.getSmashedCellsCount()
    let colorsArray       = self.getColorsArray(smashedCellsCount)
    let cellsNumbers      = self.getCellsNumbers()
    
    self.view!.tableCollectionViewCellsData             = self.getTableCollectionViewCellsData(cellsNumbers, colorsArray.map { $0.0 }, colorsArray.map { $0.1 })
    self.view!.tableCollectionViewCellsDataInRightOrder = self.view!.tableCollectionViewCellsData
    self.view!.tableCollectionViewCellsDataInRightOrder.sort { Int($0.labelText)! < Int($1.labelText)! }
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
    
    let blueShades = ["mostLight": UIColor(red: 0.784, green: 0.839, blue: 0.967, alpha: 1),
                      "light": UIColor(red: 0.176, green: 0.612, blue: 0.859, alpha: 1),
                      "blue": UIColor(red: 0.459, green: 0.608, blue: 0.98, alpha: 1),
                      "dark": UIColor(red: 0.358, green: 0.467, blue: 0.739, alpha: 1)]
    
    let greenShades = ["mostLight": UIColor(red: 0.788, green: 0.93, blue: 0.765, alpha: 1),
                       "light": UIColor(red: 0.435, green: 0.812, blue: 0.592, alpha: 1),
                       "green": UIColor(red: 0.315, green: 0.788, blue: 0.22, alpha: 1),
                       "dark": UIColor(red: 0.129, green: 0.588, blue: 0.325, alpha: 1)]
    
    let redShades = ["mostLight": UIColor(red: 0.979, green: 0.82, blue: 0.82, alpha: 1),
                     "light": UIColor(red: 1, green: 0.451, blue: 0.451, alpha: 1),
                     "red": UIColor(red: 0.992, green: 0.314, blue: 0.314, alpha: 1),
                     "dark": UIColor(red: 0.801, green: 0.265, blue: 0.265, alpha: 1)]
    
    var colorsArray = [(UIColor, UIColor)]() // [(backgroundColor, labelTextColor)]
    
    for (index, count) in smashedCellsCount.enumerated() {
      for _ in 0..<count {
        switch self.view!.settingsData.mixingShades {
        case true:
            switch colors[index] {
            case UIColor(red: 0.459, green: 0.608, blue: 0.98, alpha: 1): // Blue
                if let blueShade = blueShades.randomElement() {
                    switch blueShade.value {
                    case blueShades["mostLight"]:
                        colorsArray.append((blueShade.value, UIColor(red: 0.153, green: 0.239, blue: 0.322, alpha: 1)))
                    default:
                        colorsArray.append((blueShade.value, UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 1)))
                    }
                }
            case UIColor(red: 0.315, green: 0.788, blue: 0.22, alpha: 1): // Green
                if let greenShade = greenShades.randomElement() {
                    switch greenShade.value {
                    case greenShades["mostLight"]:
                        colorsArray.append((greenShade.value, UIColor(red: 0.153, green: 0.239, blue: 0.322, alpha: 1)))
                    default:
                        colorsArray.append((greenShade.value, UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 1)))
                    }
                }
            case UIColor(red: 0.992, green: 0.314, blue: 0.314, alpha: 1): // Red
                if let redShade = redShades.randomElement() {
                    switch redShade.value {
                    case redShades["mostLight"]:
                        colorsArray.append((redShade.value, UIColor(red: 0.153, green: 0.239, blue: 0.322, alpha: 1)))
                    default:
                        colorsArray.append((redShade.value, UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 1)))
                    }
                }
            default:
                fatalError("How did i get here?")
            }
        case false:
            switch colors[index] {
            case UIColor(red: 0.459, green: 0.608, blue: 0.98, alpha: 1): // Blue
                colorsArray.append((blueShades["dark"]!, UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 1)))
            case UIColor(red: 0.315, green: 0.788, blue: 0.22, alpha: 1): // Green
                colorsArray.append((greenShades["dark"]!, UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 1)))
            case UIColor(red: 0.992, green: 0.314, blue: 0.314, alpha: 1): // Red
                colorsArray.append((redShades["dark"]!, UIColor(red: 0.988, green: 0.988, blue: 0.988, alpha: 1)))
            default:
                fatalError("How did i get here?")
            }
            
        }
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

// MARK: - Restart Game

extension SchulteTableGamePresenter {
  func restart(from state: GameViewState) {
    if state == .popUp {
      UIView.animate(withDuration: 0.6, animations: {
        self.view?.hidePopUp()
      }, completion: { finished in
        self.view?.clearPopUp()
      })
    }
    
    self.view?.returnTimerValues()
    self.view?.makeTimer()
    
    self.view!.currentCellIndex                         = 0
    self.view!.tableCollectionViewCellsData             = [tableCollectionViewCellData]()
    self.view!.tableCollectionViewCellsDataInRightOrder = [tableCollectionViewCellData]()
    
    self.configureGame()
    
    self.view?.makeNavBarTitle(for: self.view!.tableCollectionViewCellsDataInRightOrder.first!)
    self.view!.tableCollectionView.reloadData()
  }
  
  enum GameViewState {
    case view
    case popUp
  }
}

// MARK: - PopUpBottomView Presenter Functions

extension SchulteTableGamePresenter: SchulteTableGamePopUpBottomViewPresenterDelegate {

  // MARK: - startGame
  func startGame(data: SchulteTableGameSettings) {
    UIView.animate(withDuration: 0.6, animations: {
      self.view?.hidePopUp()
    }, completion: { finished in
      self.view?.clearPopUp()
      self.view?.returnTimerValues()
      self.view?.makeTimer()
      
      self.view!.settingsData = data
      
      self.view!.currentCellIndex                         = 0
      self.view!.tableCollectionViewCellsData             = [tableCollectionViewCellData]()
      self.view!.tableCollectionViewCellsDataInRightOrder = [tableCollectionViewCellData]()
      
      self.configureGame()
      
      self.view?.makeNavBarTitle(for: self.view!.tableCollectionViewCellsDataInRightOrder.first!)
      self.view!.tableCollectionView.reloadData()
    })
  }

  // TODO: - Сделай функции для кнопок выбора кол-ва цветов
  
  // MARK: - mixingShadesSwitchValueChanged
  func mixingShadesSwitchValueChanged(_ sender: PWSwitch) {
    switch sender.on {
    case true:
      sender.layer.borderColor = UIColor(red: 0.46, green: 0.61, blue: 0.98, alpha: 0.37).cgColor
      sender.shadowOpacity = 1
    case false:
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

// MARK: - tableCollectionViewCellData
struct tableCollectionViewCellData {
  let backgroundColor : UIColor
  let labelTextColor  : UIColor
  let labelText       : String
}
